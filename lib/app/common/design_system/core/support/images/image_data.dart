class ImageAssetData {
  const ImageAssetData({
    required String name,
    String fileExtension = 'png',
  }) : path = 'assets/images/$name.$fileExtension';

  final String path;
}
