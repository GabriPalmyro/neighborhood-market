import 'package:neighborhood_market/app/common/states/models/states.dart';

Future<List<CountryState>> _loadStates() async {
  // final res = await rootBundle.loadString('assets/json/states.json');
  // final data = jsonDecode(res) as List;
  final data = [
  {
    'name': 'Washington DC',
    'isoCode': 'WA',
    'countryCode': 'US',
    'latitude': '47.75107410',
    'longitude': '-120.74013850',
  },
  {
    'name': 'Texas',
    'isoCode': 'TX',
    'countryCode': 'US',
    'latitude': '31.96859880',
    'longitude': '-99.90181310',
  },
];
  
  return List<CountryState>.from(
    data.map((item) => CountryState.fromJson(item)),
  );
}

/// Get world wide states list.
Future<List<CountryState>> getAllStates() {
  return _loadStates();
}

/// Get the list of states that belongs to a country by the country ISO CODE
Future<List<CountryState>> getStatesOfCountry(String countryCode) async {
  final states = await _loadStates();

  final res = states.where((state) {
    return state.countryCode == countryCode;
  }).toList();
  res.sort((a, b) => a.name.compareTo(b.name));

  return res;
}

/// Get a state from its code and its belonging country code
Future<CountryState?> getStateByCode(
  String countryCode,
  String stateCode,
) async {
  final states = await _loadStates();

  final res = states.where((state) {
    return state.countryCode == countryCode && state.isoCode == stateCode;
  }).toList();

  return res.isEmpty ? null : res.first;
}
