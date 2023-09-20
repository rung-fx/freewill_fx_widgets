import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:get/get.dart';

class FXOkCancelDialog extends StatelessWidget {
  final Widget? icon;
  final String title;
  final Color? titleColor;
  final String? content;
  final Color? contentColor;
  final String okTestKey;
  final Function()? onOK;
  final String? okText;
  final Color? okColor;
  final bool isGradient;
  final Color? gradientColor1;
  final Color? gradientColor2;
  final bool showCancel;
  final String cancelTestKey;
  final Function()? onCancel;
  final String? cancelText;

  const FXOkCancelDialog({
    Key? key,
    this.icon,
    required this.title,
    this.titleColor,
    this.content,
    this.contentColor,
    this.okTestKey = '',
    this.onOK,
    this.okText,
    this.okColor,
    this.isGradient = false,
    this.gradientColor1,
    this.gradientColor2,
    this.showCancel = true,
    this.cancelTestKey = '',
    this.onCancel,
    this.cancelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.only(
        left: marginX2,
        right: marginX2,
        top: marginX2,
        bottom: margin,
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon != null
                ? Column(
                    children: [
                      icon!,
                      const SizedBox(height: margin),
                    ],
                  )
                : const SizedBox(),
            FXText(
              title,
              color: titleColor ?? Colors.black,
              size: fontSizeL,
              weight: FontWeight.bold,
              align: TextAlign.center,
            ),
            Visibility(
              visible: content != null,
              child: Column(
                children: [
                  const SizedBox(height: margin),
                  FXText(
                    content ?? '',
                    color: contentColor ?? Colors.grey,
                    size: fontSizeM,
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
            Expanded(
              child: FXSubmitButton(
                key: ValueKey(okTestKey),
                onTap: () {
                  Get.back(result: true);

                  if (onOK != null) {
                    onOK!();
                  }
                },
                title: okText ?? 'ยืนยัน',
                borderRadius: 10,
                buttonPadding: EdgeInsets.zero,
                buttonHeight: 45.0,
                color: okColor ?? Colors.grey,
                isGradient: isGradient,
                gradientColor1: gradientColor1 ?? Colors.grey,
                gradientColor2: gradientColor2 ?? Colors.grey.shade300,
              ),
            ),
            showCancel ? const SizedBox(width: margin) : const SizedBox(),
            showCancel
                ? Expanded(
                    child: FXSubmitButton(
                      key: ValueKey(cancelTestKey),
                      onTap: () {
                        Get.back();

                        if (onCancel != null) {
                          onCancel!();
                        }
                      },
                      title: cancelText ?? 'ยกเลิก',
                      borderRadius: 10,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      fontColor: Colors.grey,
                      color: Colors.transparent,
                      buttonPadding: EdgeInsets.zero,
                      buttonHeight: 45.0,
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
