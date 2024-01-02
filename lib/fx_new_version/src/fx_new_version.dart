import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:url_launcher/url_launcher.dart';

Future fxNewVersion({
  required String androidId,
  required String iOsId,
  required String appName,
}) async {
  final newVersion = NewVersion(
    iOSId: iOsId,
    iOSAppStoreCountry: 'TH',
    androidId: androidId,
  );

  final status = await newVersion.getVersionStatus();

  if (status != null) {
    if (status.canUpdate) {
      showUpdateDialog(
        status,
        appName: appName,
      );
    }
  }
}

showUpdateDialog(VersionStatus status, {required String appName}) {
  Get.dialog(
    AlertDialog(
      contentPadding: const EdgeInsets.all(marginX2),
      insetPadding: const EdgeInsets.symmetric(horizontal: margin),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: margin),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FXText(
                  appName,
                  size: fontSizeL,
                ),
              ],
            ),
            const SizedBox(height: margin),
            FXText(
              'ตรวจพบแอพพลิเคชั่นเวอร์ชั่นใหม่ (${status.storeVersion})',
            ),
            const SizedBox(height: marginX2),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: marginX2,
                      vertical: margin,
                    ),
                    child: const FXText(
                      'ภายหลัง',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    launchUrl(Uri.parse(status.appStoreLink));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: marginX2,
                      vertical: margin,
                    ),
                    child: const FXText(
                      'อัพเดต',
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
