import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:miles_educations/core/services/hive_storage.dart';

void main() {
  late HiveStorage hiveStorage;

  setUp(() async {
    Hive.init('./test_hive'); // use a test directory
    hiveStorage = HiveStorage();
    await Hive.openBox('authBox');
  });

  tearDown(() async {
    await Hive.box('authBox').clear();
  });

  test('should save and get auth token', () async {
    await hiveStorage.saveAuthToken('token_abc');
    final token = hiveStorage.getAuthToken();
    expect(token, 'token_abc');
  });

  test('should clear auth token', () async {
    await hiveStorage.saveAuthToken('token_abc');
    await hiveStorage.clearAuthToken();
    final token = hiveStorage.getAuthToken();
    expect(token, isNull);
  });
}
