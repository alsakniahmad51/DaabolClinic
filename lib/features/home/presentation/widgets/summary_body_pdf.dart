import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;

class SummaryBodyPdf extends pw.StatelessWidget {
  SummaryBodyPdf({
    required this.addressTable,
    required this.date,
    required this.title,
    required this.doctorName,
    required this.orderCounts,
    required this.formattedPrice,
    required this.logoBytes, // أضف هذه
  });

  final Map<String, int> orderCounts;
  final String formattedPrice;
  final String doctorName;
  final String title;
  final String date;
  final String addressTable;
  final Uint8List logoBytes; // أضف هذه

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          // إضافة صورة الشعار
          if (logoBytes.isNotEmpty)
            pw.Image(pw.MemoryImage(logoBytes), height: 200, width: 200),
          pw.SizedBox(height: 20),
          pw.Text(
            title,
            style: const pw.TextStyle(
              fontSize: 20,
            ),
          ),
          pw.Text(
            doctorName,
            style: const pw.TextStyle(
              fontSize: 14,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            '$addressTable $date',
            textDirection: pw.TextDirection.rtl,
            textAlign: pw.TextAlign.start,
            style: const pw.TextStyle(
              fontSize: 18,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                children: [
                  pw.Text('نوع الطلب',
                      textAlign: pw.TextAlign.center,
                      textDirection: pw.TextDirection.rtl,
                      style: const pw.TextStyle(
                        fontSize: 20,
                      )),
                  pw.Text('عدد الطلبات',
                      textAlign: pw.TextAlign.center,
                      textDirection: pw.TextDirection.rtl,
                      style: const pw.TextStyle(
                        fontSize: 20,
                      )),
                ],
              ),
              ...orderCounts.entries.map((entry) {
                return pw.TableRow(
                  children: [
                    pw.Text(
                      style: const pw.TextStyle(
                        fontSize: 18,
                      ),
                      entry.value.toString(),
                      textAlign: pw.TextAlign.center,
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Text(
                      style: const pw.TextStyle(
                        fontSize: 18,
                      ),
                      entry.key,
                      textAlign: pw.TextAlign.center,
                      textDirection: pw.TextDirection.rtl,
                    ),
                  ],
                );
              }),
              pw.TableRow(
                children: [
                  pw.Text(
                    style: const pw.TextStyle(
                      fontSize: 20,
                    ),
                    '$formattedPrice ل.س',
                    textAlign: pw.TextAlign.center,
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    style: const pw.TextStyle(
                      fontSize: 20,
                    ),
                    'إجمالي الفواتير',
                    textAlign: pw.TextAlign.center,
                    textDirection: pw.TextDirection.rtl,
                  ),
                ],
              ),
            ],
          ),
        ]);
  }
}
