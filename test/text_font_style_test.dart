import 'package:flutter_test/flutter_test.dart';
import 'package:freewill_fx_widgets/text_font_style/src/text_font_style.dart';

void main() {
  test('Test TextFontStyle', () {
    const textFontStyle = TextFontStyle('data');
    expect(textFontStyle.data, 'data');
  });
}
