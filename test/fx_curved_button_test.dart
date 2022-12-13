import 'package:flutter_test/flutter_test.dart';
import 'package:freewill_fx_widgets/fx.dart';

void main() {
  test('Test FXCurvedButton', () {
    final curvedButton = FXCurvedButton(
      onTap: () {},
      width: 100,
      title: 'title',
    );
    expect(curvedButton.title, 'title');
  });
}
