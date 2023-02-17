import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx_alert_dialog/src/fx_alert_dialog.dart';
import 'package:freewill_fx_widgets/fx_image_picker/src/fx_camera_page.dart';
import 'package:freewill_fx_widgets/fx_permission/src/fx_permission.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

const double imageSize = 640.0;

enum ImagePickerSource {
  camera,
  gallery,
}

Future<File?> showImagePickerBottomSheet() async {
  ImagePickerSource? result = await Get.bottomSheet(
    Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              leading: const Icon(
                Icons.camera_alt,
                color: Colors.blue,
              ),
              title: const Text(
                'กล้อง',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                ),
              ),
              onTap: () async {
                Get.back(result: ImagePickerSource.camera);
              },
            ),
            const Divider(),
            ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              leading: const Icon(
                Icons.photo,
                color: Colors.blue,
              ),
              title: const Text(
                'แกลลอรี่',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                ),
              ),
              onTap: () async {
                Get.back(result: ImagePickerSource.gallery);
              },
            ),
          ],
        ),
      ),
    ),
  );

  File? pickedFile;

  if (result == ImagePickerSource.camera) {
    if (Platform.isAndroid) {
      final cameras = await availableCameras();
      final camera = cameras.first;
      final imagePath = await Get.to(
        () => FXCameraPage(camera: camera),
      );

      pickedFile = File(imagePath);
    } else if (Platform.isIOS) {
      pickedFile = await getImageFromCamera();
    }
  } else if (result == ImagePickerSource.gallery) {
    pickedFile = await getImageFromGallery();
  }

  return pickedFile;
}

getImageFromCamera() async {
  bool cameraEnabled = await fxCanAccessCamera();
  File? file;

  if (cameraEnabled) {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: imageSize,
      maxWidth: imageSize,
    );

    if (pickedFile != null) {
      file = File(pickedFile.path);
    }
  } else {
    Get.dialog(
      const FXAlertDialog(
        title: 'กรุณาตรวจสอบสิทธิ์ในการใช้งานกล้อง',
        buttonColor: Colors.blue,
      ),
    );
  }

  return file;
}

getImageFromGallery() async {
  bool galleryEnabled = await fxCanAccessGallery();
  File? file;

  if (galleryEnabled) {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: imageSize,
      maxWidth: imageSize,
    );

    if (pickedFile != null) {
      file = File(pickedFile.path);
    }
  } else {
    Get.dialog(
      const FXAlertDialog(
        title: 'กรุณาตรวจสอบสิทธิ์ในการเข้าแกลลอรี่',
        buttonColor: Colors.blue,
      ),
    );
  }

  return file;
}
