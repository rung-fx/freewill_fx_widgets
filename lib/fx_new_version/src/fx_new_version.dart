import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:get/get.dart';
import 'package:open_store/open_store.dart';

showUpdateDialog({
  required String appName,
  required String version,
  required String appStoreId,
  required String androidId,
  Color appNameColor = Colors.black,
  double appNameFontSize = fontSizeL,
  double versionFontSize = fontSizeM,
  bool updateLater = false,
  Color buttonColor = Colors.grey,
  String laterText = 'ภายหลัง',
  String updateText = 'อัพเดต',
  Color updateColor = Colors.grey,
}) {
  Get.dialog(
    PopScope(
      canPop: false,
      child: AlertDialog(
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
                size: appNameFontSize,
                weight: FontWeight.bold,
                align: TextAlign.center,
              ),
              const SizedBox(height: marginX2),
              FXText(
                'ตรวจพบแอพพลิเคชั่นเวอร์ชั่นใหม่ $version',
                size: versionFontSize,
                align: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              updateLater
                  ? Expanded(
                      child: FXSubmitButton(
                        onTap: () {
                          Get.back();
                        },
                        title: laterText,
                        borderRadius: 10.0,
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
                  : const SizedBox(),
              updateLater ? const SizedBox(width: marginX2) : const SizedBox(),
              Expanded(
                child: FXSubmitButton(
                  onTap: () {
                    Get.back();

                    OpenStore.instance.open(
                      appStoreId: appStoreId,
                      androidAppBundleId: androidId,
                    );
                  },
                  title: updateText,
                  borderRadius: 10.0,
                  buttonPadding: EdgeInsets.zero,
                  buttonHeight: 45.0,
                  color: updateColor,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}
