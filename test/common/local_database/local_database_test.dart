import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neighborhood_market/app/common/local_database/local_database.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

class FakeLocalStorage extends Fake implements LocalStorage {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeLocalStorage());
  });

  group('LocalStorage Tests', () {
    const key = 'testKey';
    const value = 'testValue';
    late MockLocalStorage mockLocalStorage;

    setUp(() {
      mockLocalStorage = MockLocalStorage();
    });

    test('saveData should save data correctly', () async {
      when(() => mockLocalStorage.saveData(key, value)).thenAnswer((_) async => Future.value());

      await mockLocalStorage.saveData(key, value);

      verify(() => mockLocalStorage.saveData(key, value)).called(1);
    });

    test('getData should return correct data', () async {
      when(() => mockLocalStorage.getData<String>(key)).thenAnswer((_) async => value);

      final result = await mockLocalStorage.getData<String>(key);

      expect(result, value);
      verify(() => mockLocalStorage.getData<String>(key)).called(1);
    });

    test('removeData should remove data correctly', () async {
      when(() => mockLocalStorage.removeData(key)).thenAnswer((_) async => Future.value());

      await mockLocalStorage.removeData(key);

      verify(() => mockLocalStorage.removeData(key)).called(1);
    });
  });
}
