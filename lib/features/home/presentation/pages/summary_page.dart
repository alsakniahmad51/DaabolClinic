// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/presentation/widgets/summary_body_pdf.dart';
import 'package:clinic/features/home/presentation/widgets/summary_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class SummaryPage extends StatelessWidget {
  final List<Order> ordersToday;

  const SummaryPage({
    super.key,
    required this.ordersToday,
    required this.title,
    required this.doctorName,
    required this.addressTable,
    required this.date,
  });

  final String title;
  final String doctorName;
  final String addressTable;
  final String date;
  @override
  Widget build(BuildContext context) {
    final Map<String, int> orderCounts = {
      'سيفالوماتريك': 0,
      'بانوراما': 0,
      'C.B.C.T': 0,
    };
    double totalPrice = 0;
    // String formattedDate = '';
    // if (ordersToday.isNotEmpty) {
    //   String dateTime = ordersToday[0].date.toString();
    //   var parts = dateTime.split(' ');
    //   String date = parts[0];

    //   var dateParts = date.split('-');
    //   formattedDate = '${dateParts[1]}-${dateParts[0]}';
    // }

    for (var order in ordersToday) {
      if (order.isImaged) {
        final typeName = order.detail!.type.typeName;
        orderCounts[typeName] = (orderCounts[typeName] ?? 0) + 1;
        totalPrice += order.price;
      }
    }
    final formattedPrice = intl.NumberFormat("#,###", "ar").format(totalPrice);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  title,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.h),
                Text(
                  doctorName,
                  style: TextStyle(fontSize: 16.sp),
                )
              ],
            ),
          ),
          actions: [
            IconButton(
              highlightColor: Colors.transparent,
              icon: const Icon(Icons.share),
              onPressed: () async {
                await _sharePdf(orderCounts, formattedPrice, date, context);
              },
            ),
          ],
        ),
        body: SummaryPageBody(
          orderCounts: orderCounts,
          formattedPrice: formattedPrice,
          date: date,
          title: addressTable,
        ),
      ),
    );
  }

  Future<void> _sharePdf(Map<String, int> orderCounts, String formattedPrice,
      String formattedDate, BuildContext context) async {
    try {
      Future<Uint8List> loadImageFromAssets(String path) async {
        ByteData byteData =
            await rootBundle.load(path); // تحميل الصورة كـ ByteData
        return byteData.buffer.asUint8List(); // تحويلها إلى Uint8List
      }

      Uint8List imageBytes =
          await loadImageFromAssets('assets/images/logo.png');
      final pdf = pw.Document();
      final fontData = await rootBundle.load("assets/fonts/Cairo.ttf");
      final font = pw.Font.ttf(fontData);
      pdf.addPage(
        pw.Page(
          theme: pw.ThemeData.withFont(base: font),
          build: (context) => pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: SummaryBodyPdf(
                title: title,
                doctorName: doctorName,
                formattedPrice: formattedPrice,
                orderCounts: orderCounts,
                date: formattedDate,
                addressTable: addressTable,
                logoBytes: imageBytes),
          ),
        ),
      );
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/${title}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      final xFile = XFile(filePath);

      await Share.shareXFiles([xFile], text: 'إليك $title');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          "فشل المشاركة: $e",
          textDirection: TextDirection.rtl,
        )),
      );
    }
  }
}
