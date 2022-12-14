import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx_text/fx_text.dart';
import 'package:get/get.dart';

class FXAlertDialog extends StatelessWidget {
  final String title;
  final String? content;
  final Color buttonColor;
  final Function()? onOK;

  const FXAlertDialog({
    Key? key,
    required this.title,
    this.content,
    required this.buttonColor,
    this.onOK,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FXText(
              title,
              color: Colors.black,
              size: 16.0,
              weight: FontWeight.bold,
              align: TextAlign.center,
            ),
            Visibility(
              visible: content != null,
              child: Column(
                children: [
                  const SizedBox(height: 8.0),
                  FXText(
                    content ?? '',
                    color: Colors.grey,
                    size: 14.0,
                    weight: FontWeight.bold,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.back();

                if (onOK != null) {
                  onOK!();
                }
              },
              child: Container(
                width: 140.0,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                child: const Center(
                  child: FXText(
                    '????????????',
                    size: 14.0,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
