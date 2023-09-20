import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/value_constant.dart';

class FXSelectedButtonList extends StatefulWidget {
  final bool enabledScroll;
  final List selectedItems;
  final Widget? Function(BuildContext, int)? itemBuilder;
  final List tagTitle;

  const FXSelectedButtonList({
    Key? key,
    this.enabledScroll = true,
    this.selectedItems = const [],
    this.itemBuilder,
    this.tagTitle = const [],
  }) : super(key: key);

  @override
  State<FXSelectedButtonList> createState() => _FXSelectedButtonListState();
}

class _FXSelectedButtonListState extends State<FXSelectedButtonList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: widget.enabledScroll
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemCount: widget.tagTitle.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: marginX2),
      itemBuilder: widget.itemBuilder ??
          (context, index) {
            return const SizedBox();
          },
      separatorBuilder: (context, index) {
        return const SizedBox(width: margin);
      },
    );
  }
}
