abstract class LocalStorage {
  Future<void> saveData<T>(String key, T value);
  Future<T> getData<T>(String key);
  Future<void> removeData(String key);
}