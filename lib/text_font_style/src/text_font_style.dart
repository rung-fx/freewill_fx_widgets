import 'package:flutter/material.dart';

class TextFontStyle extends StatelessWidget {
  final String data;
  final String? fontFamily;
  final double? size;
  final Color? color;
  final TextAlign? align;
  final FontWeight? weight;
  final TextOverflow? overflow;

  const TextFontStyle(
      this.data, {
        Key? key,
        this.fontFamily,
        this.size = 12.0,
        this.color = Colors.black,
        this.align = TextAlign.left,
        this.weight = FontWeight.normal,
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
        overflow: overflow,
      ),
    );
  }
}
