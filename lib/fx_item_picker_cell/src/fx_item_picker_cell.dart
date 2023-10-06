import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:get/get.dart';

class FXItemPickerCell extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Color? selectedColor;

  const FXItemPickerCell({
    Key? key,
    required this.title,
    required this.isSelected,
    this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(
        horizontal: marginX2,
        vertical: 5.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: marginX2,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1.0,
            blurRadius: 3.0,
            offset: const Offset(1.0, 1.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: FXText(
              title,
              weight: FontWeight.bold,
              size: fontSizeL,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          Visibility(
            visible: isSelected ? true : false,
            child: const Icon(
              Icons.check,
              size: 18.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
