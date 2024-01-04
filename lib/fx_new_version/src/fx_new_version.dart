import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

showUpdateDialog({
  required String appName,
  required String version,
  required String url,
  Color appNameColor = Colors.black,
  bool updateLater = false,
  Color buttonColor = Colors.grey,
  String laterText = 'ภายหลัง',
  String updateText = 'อัพเดต',
  Color updateColor = Colors.grey,
}) {
  Get.dialog(
    AlertDialog(
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
            FXText(
              appName,
              color: appNameColor,
              size: fontSizeL,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: marginX2),
            FXText(
              'ตรวจพบแอพพลิเคชั่นเวอร์ชั่นใหม่ $version',
              size: fontSizeL,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            updateLater
                ? FXSubmitButton(
                    onTap: () {
                      Get.back();
                    },
                    title: laterText,
                    borderRadius: 10,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                    fontColor: Colors.grey,
                    color: Colors.transparent,
                    buttonPadding: EdgeInsets.zero,
                    buttonHeight: 45.0,
                  )
                : const SizedBox(),
            FXSubmitButton(
              onTap: () {
                Get.back();
                launchUrl(Uri.parse(url));
              },
              title: updateText,
              borderRadius: 10,
              buttonPadding: EdgeInsets.zero,
              buttonHeight: 45.0,
              color: updateColor,
            ),
          ],
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
