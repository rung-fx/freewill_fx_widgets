import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freewill_fx_widgets/fx_text/fx_text.dart';

void main() {
  test('Test FXText', () {
    const textFontStyle = FXText('data');
    expect(textFontStyle.data, 'data');
    expect(textFontStyle.color, Colors.black);
  });
}
