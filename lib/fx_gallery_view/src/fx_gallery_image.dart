import 'package:freewill_fx_widgets/fx_gallery_view/src/fx_gallery_image_type.dart';

class FXGalleryImage {
  final String imagePath;
  final String description;
  final FXGalleryImageType imageType;

  FXGalleryImage({
    required this.imagePath,
    this.description = '',
    this.imageType = FXGalleryImageType.network,
  });
}
