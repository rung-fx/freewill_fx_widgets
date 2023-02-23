import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx_gallery_view/src/fx_gallery_image.dart';
import 'package:freewill_fx_widgets/fx_gallery_view/src/fx_gallery_image_type.dart';
import 'package:freewill_fx_widgets/fx_page_indicator/src/fx_page_indicator.dart';
import 'package:get/get.dart';

showFXGalleryView({
  required List<FXGalleryImage> itemList,
  bool barrierDismissible = true,
  Color barrierColor = Colors.black38,
  Color textColor = Colors.white,
  Color indicatorActiveColor = Colors.white,
  Color indicatorInactiveColor = Colors.white54,
  Color descriptionBackgroundColor = Colors.black26,
  Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
}) {
  Get.generalDialog(
    barrierLabel: '',
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    pageBuilder: (context, animation, secondaryAnimation) {
      return SafeArea(
        child: FXGalleryPage(
          itemList: itemList,
          textColor: textColor,
          indicatorActiveColor: indicatorActiveColor,
          indicatorInactiveColor: indicatorInactiveColor,
          descriptionBackgroundColor: descriptionBackgroundColor,
          errorBuilder: errorBuilder,
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
  final Color descriptionBackgroundColor;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const FXGalleryPage({
    Key? key,
    required this.itemList,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.white,
    this.indicatorActiveColor = Colors.white,
    this.indicatorInactiveColor = Colors.white54,
    this.descriptionBackgroundColor = Colors.black26,
    this.errorBuilder,
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

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InteractiveViewer(
                      child: _imageWidget(item),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: _currentItem?.description != null &&
                  _currentItem?.description != '',
              child: Container(
                margin: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 8.0,
                ),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: widget.descriptionBackgroundColor,
                ),
                child: Row(
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
              ),
            ),
            const SizedBox(height: 8.0),
            FXPageIndicator(
              pageSize: widget.itemList.length,
              currentPage: _currentIndex,
              activeColor: widget.indicatorActiveColor,
              inactiveColor: widget.indicatorInactiveColor,
            ),
          ],
        ),
      ),
    );
  }

  _imageWidget(FXGalleryImage item) {
    switch (item.imageType) {
      case FXGalleryImageType.network:
        return Image.network(
          item.imagePath,
          errorBuilder: widget.errorBuilder ?? _defaultErrorBuilder,
        );

      case FXGalleryImageType.asset:
        return Image.asset(
          item.imagePath,
          errorBuilder: widget.errorBuilder ?? _defaultErrorBuilder,
        );

      default:
        return _brokenImage();
    }
  }

  Widget _defaultErrorBuilder(
    BuildContext context,
    Object obj,
    StackTrace? trace,
  ) {
    return _brokenImage();
  }

  _brokenImage() {
    return Center(
      child: Container(
        width: 180.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.black38,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.broken_image_outlined,
              size: 40.0,
              color: Colors.white,
            ),
            SizedBox(height: 16.0),
            Text(
              'Cannot load image',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
