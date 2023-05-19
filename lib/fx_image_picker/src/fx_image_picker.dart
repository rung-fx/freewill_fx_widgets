import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

const double imageSize = 640.0;

enum ImagePickerSource {
  camera,
  gallery,
}

Future<File?> showImagePickerBottomSheet({
  required bool cropImage,
  Color iconColor = Colors.grey,
  Color fontColor = Colors.black,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
  double fontSize = fontSizeL,
  File? image,
  double? ratioX,
  double? ratioY,
}) async {
  if (cropImage) {
    File? result = await Get.bottomSheet(
      Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                contentPadding: padding,
                leading: Icon(
                  Icons.camera_alt,
                  color: iconColor,
                ),
                title: FXText(
                  'กล้อง',
                  size: fontSize,
                  weight: FontWeight.bold,
                  color: fontColor,
                ),
                onTap: () async {
                  final cameras = await availableCameras();

                  File? file = await Get.to(
                    () => FXCameraPage(
                      cameras: cameras,
                      resolution: ResolutionPreset.medium,
                    ),
                  );

                  image = await cameraCrop(
                    file!.path,
                    ratioX: ratioX ?? 1.0,
                    ratioY: ratioY ?? 1.0,
                  );

                  Get.back(result: image);
                },
              ),
              const Divider(),
              ListTile(
                contentPadding: padding,
                leading: Icon(
                  Icons.photo,
                  color: iconColor,
                ),
                title: FXText(
                  'แกลลอรี่',
                  size: fontSize,
                  weight: FontWeight.bold,
                  color: fontColor,
                ),
                onTap: () async {
                  final file = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    maxHeight: imageSize,
                    maxWidth: imageSize,
                  );

                  image = await cameraCrop(
                    file!.path,
                    ratioX: ratioX ?? 1.0,
                    ratioY: ratioY ?? 1.0,
                  );

                  Get.back(result: image);
                },
              ),
            ],
          ),
        ),
      ),
    );

    return result;
  } else {
    ImagePickerSource? result = await Get.bottomSheet(
      Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                contentPadding: padding,
                leading: Icon(
                  Icons.camera_alt,
                  color: iconColor,
                ),
                title: FXText(
                  'กล้อง',
                  size: fontSize,
                  weight: FontWeight.bold,
                  color: fontColor,
                ),
                onTap: () async {
                  Get.back(result: ImagePickerSource.camera);
                },
              ),
              const Divider(),
              ListTile(
                contentPadding: padding,
                leading: Icon(
                  Icons.photo,
                  color: iconColor,
                ),
                title: FXText(
                  'แกลลอรี่',
                  size: fontSize,
                  weight: FontWeight.bold,
                  color: fontColor,
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
        pickedFile = await Get.to(
          () => FXCameraPage(
            cameras: cameras,
            resolution: ResolutionPreset.medium,
          ),
        );
      } else if (Platform.isIOS) {
        pickedFile = await getImageFromCamera(iconColor);
      }
    } else if (result == ImagePickerSource.gallery) {
      pickedFile = await getImageFromGallery(iconColor);
    }

    return pickedFile;
  }
}

getImageFromCamera(Color buttonColor) async {
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
      FXAlertDialog(
        title: 'กรุณาตรวจสอบสิทธิ์ในการใช้งานกล้อง',
        buttonColor: buttonColor,
      ),
    );
  }

  return file;
}

getImageFromGallery(Color buttonColor) async {
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
      FXAlertDialog(
        title: 'กรุณาตรวจสอบสิทธิ์ในการเข้าแกลลอรี่',
        buttonColor: buttonColor,
      ),
    );
  }

  return file;
}

Future<File?> cameraCrop(
  filePath, {
  required double ratioX,
  required double ratioY,
}) async {
  var aspectRatio = CropAspectRatio(
    ratioX: ratioX,
    ratioY: ratioY,
  );
  CroppedFile? croppedImage = await ImageCropper().cropImage(
    sourcePath: filePath,
    maxWidth: 720,
    maxHeight: 720,
    aspectRatio: aspectRatio,
    cropStyle: CropStyle.rectangle,
    uiSettings: [
      IOSUiSettings(
        rotateClockwiseButtonHidden: true,
        rotateButtonsHidden: true,
        resetButtonHidden: true,
        aspectRatioPickerButtonHidden: true,
        aspectRatioLockDimensionSwapEnabled: true,
        aspectRatioLockEnabled: true,
      ),
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: true,
      ),
    ],
  );

  File? file = File(croppedImage!.path);

  return file;
}

Future<File?> galleryCrop(File imageFile) async {
  CroppedFile? croppedImage = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
    ],
    uiSettings: [
      IOSUiSettings(
        aspectRatioLockEnabled: false,
        resetAspectRatioEnabled: false,
      ),
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
    ],
  );

  File? file = File(croppedImage!.path);

  return file;
}
