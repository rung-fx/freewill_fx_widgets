import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/value_constant.dart';

class FXSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool? isDense;
  final Function()? onDelete;
  final String? hintText;
  final double? hintSize;

  const FXSearchBar({
    Key? key,
    required this.controller,
    this.onChanged,
    this.isDense,
    this.onDelete,
    this.hintText,
    this.hintSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.text,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: TextInputAction.done,
      style: const TextStyle(
        fontSize: fontSizeL,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        isDense: isDense,
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.only(
          left: 20.0,
          top: margin,
          bottom: margin,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black,
        ),
        suffixIcon:
            controller.text != ''
                ? InkWell(
                    onTap: onDelete,
                    child: const Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  )
                : const SizedBox(),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: hintSize,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
