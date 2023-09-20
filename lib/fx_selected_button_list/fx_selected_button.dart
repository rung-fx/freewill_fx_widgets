import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';

class TagButton extends StatelessWidget {
  final String testKey;
  final Function() onTap;
  final String title;
  final bool lastItem;
  final Color color;
  final Color fontColor;
  final double? fontSize;

  const TagButton({
    Key? key,
    this.testKey = '',
    required this.onTap,
    required this.title,
    this.lastItem = false,
    required this.color,
    required this.fontColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey(testKey),
      onTap: onTap,
      child: Container(
        height: 35.0,
        padding: const EdgeInsets.symmetric(
          horizontal: marginX2,
          vertical: 4.0,
        ),
        margin: EdgeInsets.only(
          right: !lastItem ? 4.0 : marginX2,
          top: 4.0,
          bottom: 4.0,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1.0,
              blurRadius: 3.0,
              offset: const Offset(1.0, 1.0),
            )
          ],
        ),
        child: Center(
          child: FXText(
            title,
            size: fontSize ?? fontSizeM,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}