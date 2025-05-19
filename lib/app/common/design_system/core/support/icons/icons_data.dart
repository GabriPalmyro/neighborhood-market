class IconAssetData {
  const IconAssetData(
    String identifier, {
    String extension = 'png',
  }) : path = 'assets/icons/$identifier.$extension';

  final String path;
}
