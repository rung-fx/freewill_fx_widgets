import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/value_constant.dart';

class FXBottomSheet extends StatelessWidget {
  final Widget child;

  const FXBottomSheet({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: customBoxShadow,
      ),
      child: child,
    );
  }
}