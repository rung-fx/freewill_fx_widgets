import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

class FXItemPicker extends StatefulWidget {
  final String title;
  final String? hintText;
  final List items;
  final Widget Function(dynamic item, bool isSelected) itemWidget;
  final Widget Function(dynamic item) tagWidget;
  final dynamic Function(String searchText) onSearch;
  final int maximumItem;
  final bool pickMultipleItem;
  final List selectedItems;
  final bool enabledSelect;
  final String confirmButtonTestKey;
  final bool showConfirmButton;
  final String? noDataText;
  final String? confirmText;

  const FXItemPicker({
    Key? key,
    required this.title,
    this.hintText,
    required this.items,
    required this.itemWidget,
    required this.tagWidget,
    required this.onSearch,
    this.maximumItem = 99,
    this.pickMultipleItem = true,
    required this.selectedItems,
    this.enabledSelect = true,
    this.confirmButtonTestKey = '',
    this.showConfirmButton = true,
    this.noDataText,
    this.confirmText,
  }) : super(key: key);

  @override
  State<FXItemPicker> createState() => _FXItemPickerState();
}

class _FXItemPickerState extends State<FXItemPicker> {
  final TextEditingController _searchController = TextEditingController();
  List _filteredItems = [];

  late StreamSubscription<bool> _keyboardSubscription;
  bool _keyboardIsVisible = false;
  late int _maximumItem;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;

    if (widget.pickMultipleItem) {
      _maximumItem = widget.maximumItem;
    } else {
      _maximumItem = 1;
    }

    _keyboardSubscription = KeyboardVisibilityController().onChange.listen(
          (bool visible) {
        _keyboardIsVisible = visible;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _keyboardSubscription.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        leading: FXBackButton(
          onTap: () {
            Get.back();
          },
          showCircle: true,
          showBorder: true,
          iconColor: Colors.black,
        ),
        title: FXText(
          widget.title,
          color: Colors.black,
          size: fontAppBar,
          weight: FontWeight.bold,
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _searchBar(),
          const SizedBox(height: margin),
          _selectedTag(),
          Expanded(
            child: _dataList(),
          ),
          const SizedBox(height: margin),
          _confirmButton(),
        ],
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: marginX2),
      child: FXSearchBar(
        controller: _searchController,
        hintText: widget.hintText ?? 'ค้นหา',
        onChanged: (value) {
          _filteredItems = widget.onSearch(value);
          setState(() {});
        },
        onDelete: () {
          _searchController.clear();
          _filteredItems = widget.items;
          setState(() {});
        },
      ),
    );
  }

  _selectedTag() {
    return Visibility(
      visible: widget.selectedItems.isNotEmpty,
      child: Column(
        children: [
          SizedBox(
            height: 65.0,
            child: ListView.separated(
              padding: const EdgeInsets.only(
                left: marginX2,
                right: marginX2,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: widget.selectedItems.length,
              itemBuilder: (context, index) {
                var item = widget.selectedItems[index];

                return badges.Badge(
                  onTap: () {
                    widget.selectedItems.remove(item);
                    setState(() {});
                  },
                  position: badges.BadgePosition.topEnd(top: -5, end: -8),
                  badgeAnimation:
                      const badges.BadgeAnimation.slide(toAnimate: false),
                  badgeContent: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 16.0,
                  ),
                  badgeStyle:
                      const badges.BadgeStyle(padding: EdgeInsets.all(2.0)),
                  child: widget.tagWidget(item),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: margin);
              },
            ),
          ),
          const SizedBox(height: margin),
        ],
      ),
    );
  }

  _dataList() {
    return _filteredItems.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              var item = _filteredItems[index];
              bool isSelected = widget.selectedItems.contains(item);

              return InkWell(
                onTap: widget.enabledSelect
                    ? () {
                        if (isSelected) {
                          widget.selectedItems.remove(item);
                        } else {
                          if (widget.pickMultipleItem) {
                            if (widget.selectedItems.length < _maximumItem) {
                              widget.selectedItems.insert(0, item);
                            }
                          } else {
                            widget.selectedItems.clear();
                            widget.selectedItems.add(item);
                          }
                        }

                        setState(() {});
                      }
                    : null,
                child: widget.itemWidget(
                  item,
                  isSelected,
                ),
              );
            },
          )
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: FXText(
              widget.noDataText ?? 'ไม่พบข้อมูล',
              size: fontSizeL,
              color: Colors.black,
            ),
          );
  }

  _confirmButton() {
    bool enabled = widget.selectedItems.isNotEmpty;

    return Visibility(
      visible: widget.showConfirmButton && !_keyboardIsVisible,
      child: SafeArea(
        child: enabled
            ? FXSubmitButton(
                key: ValueKey(widget.confirmButtonTestKey),
                onTap: () {
                  Get.back(result: widget.selectedItems);
                },
                buttonMargin: const EdgeInsets.all(marginX2),
                borderRadius: 10,
                title: widget.confirmText ?? 'ยืนยัน',
              )
            : FXSubmitButton(
                onTap: () {},
                buttonMargin: const EdgeInsets.all(marginX2),
                borderRadius: 10,
                color: Colors.transparent,
                fontColor: Colors.grey.shade400,
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 1.5,
                ),
                title: widget.confirmText ?? 'ยืนยัน',
              ),
      ),
    );
  }
}
