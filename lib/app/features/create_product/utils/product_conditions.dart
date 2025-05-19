final productConditions = [
  'New',
  'Never worn',
  'Like new',
  'Lightly used',
];

final productClothingSizes = [
  'XS',
  'S',
  'M',
  'L',
  'XL',
  'XXL',
  'XXXL',
];

final productShoeSizes = [
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
];

enum ProductGender {
  mens('Men\'s', 'men'),
  womens('Women\'s', 'woman'),
  allGenders('All Genders', 'all');

  const ProductGender(this.label, this.value);

  static ProductGender fromString(String value) {
    switch (value) {
      case 'men':
        return ProductGender.mens;
      case 'mens':
        return ProductGender.mens;
      case 'women':
        return ProductGender.womens;
      case 'womens':
        return ProductGender.womens;
      case 'all':
        return ProductGender.allGenders;
      default:
        return ProductGender.allGenders;
    }
  }

  final String label;
  final String value;
}
