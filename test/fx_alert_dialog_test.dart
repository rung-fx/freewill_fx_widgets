import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freewill_fx_widgets/fx_alert_dialog/src/fx_alert_dialog.dart';

void main() {
  test('Test FXAlertDialog', () {
    const alertDialog = FXAlertDialog(
      title: 'title',
      buttonColor: Colors.amber,
    );
    expect(alertDialog.title, 'title');
    expect(alertDialog.buttonColor, Colors.amber);
  });
}
