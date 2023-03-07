# FreewillFxWidgets

This package is simple widgets for FreewillFx Apps.

## Installation

1. Add the latest version of package to your pubspec.yaml and run `flutter pub get`

```
dependencies:
    freewill_fx_widgets: ^1.2.1
```

2. Import the package and use in your Flutter App

```
import 'package: freewill_fx_widgets/fx.dart';
```

## TextFontStyle

Text widget that you can modify TextStyle:

- FontFamily
- FontSize
- Color
- TextAlign
- FontWeight
- TextOverflow
- Underline

## AlertDialog

Dialog that you can modify the title of the dialog

- title
- buttonColor

## Loading

Loading page

## CurvedButton

Button that you can modify the style:

- Title
- TestKey
- BackgroundColor
- Padding
- BorderWidth
- BorderRadius
- BorderWidth
- BorderColor
- Shadow
- TextColor
- FontSize

## PermissionHandler

- Camera
- Gallery
- Location

## ImagePicker

- From camera
- From gallery

## PageIndicator

## GalleryView

## CropImage

In showImageBottomSheet -> cropImage = true

Example: 
```
File? file = await showImagePickerBottomSheet(
    color: Colors.black,
    cropImage: true,
);

setState(() => _image = file);
```

## QRCodeScanner

Example: 
```
Barcode? result = await Get.to(() => FXQrScanner());

if (result != null) {
    setState(() => qrResult = result);
}
```