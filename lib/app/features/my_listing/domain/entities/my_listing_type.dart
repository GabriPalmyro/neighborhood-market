enum MyListingType {
  published('published'),
  sold('sold'),	
  canceled('canceled');

  const MyListingType(this.path);
  final String path;
}
