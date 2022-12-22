import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/value_constant.dart';

class FXText extends StatelessWidget {
  final String data;
  final String? fontFamily;
  final double? size;
  final Color? color;
  final TextAlign? align;
  final FontWeight? weight;
  final TextDecoration? underline;
  final TextOverflow? overflow;

  const FXText(
      this.data, {
        Key? key,
        this.fontFamily,
        this.size = fontSizeS,
        this.color = Colors.black,
        this.align = TextAlign.left,
        this.weight = FontWeight.normal,
        this.underline = TextDecoration.none,
        this.overflow,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: align,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        color: color,
        fontWeight: weight,
        decoration: underline,
        overflow: overflow,
      ),
    );
  }
}
