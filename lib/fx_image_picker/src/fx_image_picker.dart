import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum ImagePickerSource {
  camera,
  gallery,
}

Future<Object?> showImagePickerBottomSheet({
  required bool cropImage,
  required bool useImagePicker,
  Color iconColor = Colors.grey,
  Color fontColor = Colors.black,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: marginX2),
  double modalFontSize = fontSizeL,
  File? image,
  CropAspectRatio? aspectRatio,
  String toolBarTitle = 'Crop Image',
  Color toolbarColor = Colors.grey,
  Color toolbarWidgetColor = Colors.white,
  bool hideBottomControls = true,
  bool lockAspectRatio = false,
  double? imageHeight,
  double? imageWidth,
  int? imageQuality,
  ResolutionPreset resolutionPreset = ResolutionPreset.medium,
  bool pickMultiple = false,
}) async {
  if (cropImage) {
    File? result = await Get.bottomSheet(
      Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: padding,
                leading: Icon(
                  Icons.camera_alt,
                  color: iconColor,
                ),
                title: FXText(
                  'กล้อง',
                  size: modalFontSize,
                  weight: FontWeight.bold,
                  color: fontColor,
                ),
                onTap: () async {
                  final cameras = await availableCameras();

                  File? file = await Get.to(
                    () => FXCameraPage(
                      cameras: cameras,
                      resolution: resolutionPreset,
                    ),
                  );

                  image = await cameraCrop(
                    file!.path,
                    aspectRatio: aspectRatio,
                    toolbarTitle: toolBarTitle,
                    toolbarColor: toolbarColor,
                    toolbarWidgetColor: toolbarWidgetColor,
                    hideBottomControls: hideBottomControls,
                    lockAspectRatio: lockAspectRatio,
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
                  size: modalFontSize,
                  weight: FontWeight.bold,
                  color: fontColor,
                ),
                onTap: () async {
                  final file = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    maxHeight: imageHeight,
                    maxWidth: imageWidth,
                    imageQuality: imageQuality,
                  );

                  image = await cameraCrop(
                    file!.path,
                    aspectRatio: aspectRatio,
                    toolbarTitle: toolBarTitle,
                    toolbarColor: toolbarColor,
                    toolbarWidgetColor: toolbarWidgetColor,
                    hideBottomControls: hideBottomControls,
                    lockAspectRatio: lockAspectRatio,
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
            children: [
              ListTile(
                contentPadding: padding,
                leading: Icon(
                  Icons.camera_alt,
                  color: iconColor,
                ),
                title: FXText(
                  'กล้อง',
                  size: modalFontSize,
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
                  size: modalFontSize,
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
    List<File> listPickedFile = [];

    if (result == ImagePickerSource.camera) {
      if (Platform.isAndroid) {
        if (useImagePicker) {
          pickedFile = await getImageFromCamera(
            buttonColor: iconColor,
            imageHeight: imageHeight,
            imageWidth: imageWidth,
            imageQuality: imageQuality,
          );

          if (pickMultiple) {
            listPickedFile.add(pickedFile!);
          }
        } else {
          final cameras = await availableCameras();
          pickedFile = await Get.to(
            () => FXCameraPage(
              cameras: cameras,
              resolution: resolutionPreset,
            ),
          );

          if (pickMultiple) {
            listPickedFile.add(pickedFile!);
          }
        }
      } else if (Platform.isIOS) {
        pickedFile = await getImageFromCamera(
          buttonColor: iconColor,
          imageHeight: imageHeight,
          imageWidth: imageWidth,
          imageQuality: imageQuality,
        );

        if (pickMultiple) {
          listPickedFile.add(pickedFile!);
        }
      }
    } else if (result == ImagePickerSource.gallery) {
      if (pickMultiple) {
        listPickedFile = await getImageFromGallery(
          buttonColor: iconColor,
          imageHeight: imageHeight,
          imageWidth: imageWidth,
          imageQuality: imageQuality,
          pickMultiple: pickMultiple,
        );
      } else {
        pickedFile = await getImageFromGallery(
          buttonColor: iconColor,
          imageHeight: imageHeight,
          imageWidth: imageWidth,
          imageQuality: imageQuality,
          pickMultiple: pickMultiple,
        );
      }
    }

    if (pickMultiple) {
      return listPickedFile;
    } else {
      return pickedFile;
    }
  }
}

getImageFromCamera({
  required Color buttonColor,
  double? imageHeight,
  double? imageWidth,
  int? imageQuality,
}) async {
  bool cameraEnabled = await fxCanAccessCamera();
  File? file;

  if (cameraEnabled) {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: imageHeight,
      maxWidth: imageWidth,
      imageQuality: imageQuality,
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

getImageFromGallery({
  required Color buttonColor,
  bool pickMultiple = false,
  double? imageHeight,
  double? imageWidth,
  int? imageQuality,
}) async {
  bool galleryEnabled = await fxCanAccessGallery();
  File? file;
  List<File> fileList = [];

  if (galleryEnabled) {
    final imagePicker = ImagePicker();

    if (pickMultiple) {
      final pickedFile = await imagePicker.pickMultiImage(
        maxHeight: imageHeight,
        maxWidth: imageWidth,
        imageQuality: imageQuality,
      );

      if (pickedFile.isNotEmpty) {
        for (XFile data in pickedFile) {
          file = File(data.path);
          fileList.add(file);
        }
      }
    } else {
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: imageHeight,
        maxWidth: imageWidth,
        imageQuality: imageQuality,
      );

      if (pickedFile != null) {
        file = File(pickedFile.path);
      }
    }
  } else {
    Get.dialog(
      FXAlertDialog(
        title: 'กรุณาตรวจสอบสิทธิ์ในการเข้าแกลลอรี่',
        buttonColor: buttonColor,
      ),
    );
  }

  if (pickMultiple) {
    return fileList;
  } else {
    return file;
  }
}

Future<File?> cameraCrop(
  filePath, {
  CropAspectRatio? aspectRatio,
  String toolbarTitle = 'Crop Image',
  Color toolbarColor = Colors.red,
  Color toolbarWidgetColor = Colors.white,
  bool hideBottomControls = true,
  bool lockAspectRatio = false,
}) async {
  CroppedFile? croppedImage = await ImageCropper().cropImage(
    sourcePath: filePath,
    aspectRatio: aspectRatio,
    cropStyle: CropStyle.rectangle,
    compressFormat: ImageCompressFormat.png,
    compressQuality: 100,
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
        toolbarTitle: toolbarTitle,
        toolbarColor: toolbarColor,
        toolbarWidgetColor: toolbarWidgetColor,
        hideBottomControls: hideBottomControls,
        lockAspectRatio: lockAspectRatio,
      ),
    ],
  );

  File? file = File(croppedImage!.path);

  return file;
}

Future<File?> galleryCrop({
  required File imageFile,
  String toolbarTitle = 'Crop Image',
  Color toolbarColor = Colors.red,
  Color toolbarWidgetColor = Colors.white,
  Color backgroundColor = Colors.black,
  bool hideBottomControls = true,
  bool lockAspectRatio = false,
}) async {
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
        toolbarTitle: toolbarTitle,
        toolbarColor: toolbarColor,
        toolbarWidgetColor: toolbarWidgetColor,
        backgroundColor: backgroundColor,
        hideBottomControls: hideBottomControls,
        lockAspectRatio: lockAspectRatio,
      ),
    ],
  );

  File? file = File(croppedImage!.path);

  return file;
}
