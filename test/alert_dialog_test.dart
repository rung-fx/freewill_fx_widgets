import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freewill_fx_widgets/alert_dialog/alert_dialog.dart';

void main() {
  test('Test TextFontStyle', () {
    const alertDialog = CustomAlertDialog(
      title: 'title',
      buttonColor: Colors.amber,
    );
    expect(alertDialog.title, 'title');
    expect(alertDialog.buttonColor, Colors.amber);
  });
}
