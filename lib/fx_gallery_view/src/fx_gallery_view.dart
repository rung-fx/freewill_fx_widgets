import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx_gallery_view/src/fx_gallery_image.dart';
import 'package:freewill_fx_widgets/fx_gallery_view/src/fx_gallery_image_type.dart';
import 'package:freewill_fx_widgets/fx_page_indicator/src/fx_page_indicator.dart';
import 'package:get/get.dart';

showGalleryView(
  List<FXGalleryImage> itemList, {
  Color barrierColor = Colors.black38,
  bool barrierDismissible = true,
}) {
  Get.generalDialog(
    barrierLabel: '',
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    pageBuilder: (context, animation, secondaryAnimation) {
      return SafeArea(
        child: FXGalleryPage(
          itemList: itemList,
        ),
      );
    },
  );
}

class FXGalleryPage extends StatefulWidget {
  final List<FXGalleryImage> itemList;
  final Color backgroundColor;
  final Color textColor;
  final Color indicatorActiveColor;
  final Color indicatorInactiveColor;

  const FXGalleryPage({
    Key? key,
    required this.itemList,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.white,
    this.indicatorActiveColor = Colors.blue,
    this.indicatorInactiveColor = Colors.white10,
  }) : super(key: key);

  @override
  State<FXGalleryPage> createState() => _FXGalleryPageState();
}

class _FXGalleryPageState extends State<FXGalleryPage> {
  int _currentIndex = 0;
  FXGalleryImage? _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.itemList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Get.back();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  _currentIndex = index;
                  _currentItem = widget.itemList[index];

                  setState(() {});
                },
                itemCount: widget.itemList.length,
                itemBuilder: (context, index) {
                  FXGalleryImage item = widget.itemList[index];

                  return InteractiveViewer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _imageWidget(item),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _currentItem?.description ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  FXPageIndicator(
                    pageSize: widget.itemList.length,
                    currentPage: _currentIndex,
                    activeColor: widget.indicatorActiveColor,
                    inactiveColor: widget.indicatorInactiveColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _imageWidget(FXGalleryImage item) {
    switch (item.imageType) {
      case FXGalleryImageType.network:
        return Image.network(item.imagePath);

      case FXGalleryImageType.asset:
        return Image.asset(item.imagePath);

      default:
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.broken_image_outlined,
                size: 40.0,
                color: Colors.black12,
              ),
            ],
          ),
        );
    }
  }
}
