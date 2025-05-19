/// Handle state data such as: (name, countryCode, isoCode, latitude, longitude)
class CountryState {
  CountryState({
    required this.name,
    required this.countryCode,
    required this.isoCode,
    this.latitude,
    this.longitude,
  });

  final String name;
  final String countryCode;
  final String isoCode;
  final String? latitude;
  final String? longitude;

  static CountryState fromJson(Map<String, dynamic> json) => CountryState(
        name: json['name'],
        countryCode: json['countryCode'],
        isoCode: json['isoCode'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'countryCode': countryCode,
        'isoCode': isoCode,
        'latitude': latitude,
        'longitude': longitude,
      };
}