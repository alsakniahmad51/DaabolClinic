// ignore_for_file: deprecated_member_use

import 'package:clinic/core/util/constants.dart';
import 'package:clinic/core/util/widgets/custom_text_field.dart';
import 'package:clinic/features/examinatios_prices/presentation/manager/output_cubit/output_cubit.dart';
import 'package:clinic/features/home/domain/Entities/output.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutputItem extends StatelessWidget {
  const OutputItem({
    super.key,
    required this.output,
  });

  final Output output;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          output.type,
                          style: style(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'السعر : ${output.price}',
                          style: style().copyWith(color: AppColor.primaryColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showEditPriceSheet(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle style() => TextStyle(fontSize: 18.sp);

  void _showEditPriceSheet(BuildContext context) {
    final TextEditingController priceController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'تعديل السعر',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                enableColor: AppColor.primaryColor,
                focuseColor: AppColor.primaryColor,
                title: 'أدخل السعر الجديد',
                radius: 8.0,
                textEditingController: priceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب ألا يكون الحقل فارغًا';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final newPrice = int.tryParse(priceController.text);

                    if (newPrice != null) {
                      context
                          .read<OutputCubit>()
                          .updateOutputPrice(output.id, newPrice);

                      context.read<OutputCubit>().fetchOutputDetails();
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text('تأكيد التعديل'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
