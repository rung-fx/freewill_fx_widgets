# FreewillFxWidgets

This package is simple widgets for FreewillFx Apps.

## Installation

1. Add the latest version of package to your pubspec.yaml and run `flutter pub get`

```
dependencies:
    freewill_fx_widgets: ^1.3.3
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

## SubmitButton

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


## OkCancelDialog

- Alert Dialog that you can custom your own title, icon, content, button

## Switch

- Custom switch that you can add text in the switch

## OTPTextField

- OTP TextField that you can use in automate test

## ToastMessage

- Custom toast message (e.g. copy to clipboard)

## BackButton

- Back button that you can custom icon, shadow, add circle border

## SelectedButton

- List of selected button (e.g. filter group in TERMINUS Mobile)

## ItemPickerPage & ItemPickerCell

- Select Item page that you can custom selected tag, picker cell, single/multiple select

## SearchBar

- custom search bar

## Calendar

- Calendar that made with Syncfusion date range picker

## BottomSheet 

- Template of Bottom Sheet