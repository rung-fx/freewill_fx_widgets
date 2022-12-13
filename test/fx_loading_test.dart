import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freewill_fx_widgets/fx.dart';

void main() {
  test('Test FXLoading', () {
    const loading = FXLoading(
      color: Colors.amber,
    );
    expect(loading.color, Colors.amber);
  });
}
