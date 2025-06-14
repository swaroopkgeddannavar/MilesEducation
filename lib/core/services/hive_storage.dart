import 'package:hive/hive.dart';

class HiveStorage {
  final Box<String> _box = Hive.box<String>('authBox');

  String? getAuthToken() => _box.get('token');

  Future<void> saveAuthToken(String token) async {
    await _box.put('token', token);
  }

  Future<void> clearAuthToken() async {
    await _box.delete('token');
  }
}
