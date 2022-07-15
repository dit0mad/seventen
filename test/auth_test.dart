import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:seventen/controllers.dart/user_controller.dart';
import 'package:seventen/models/user.dart' as userModel;

class MockFirebaseAuth extends Mock implements UserController {}

class MockUser extends Mock implements userModel.User {}

void main() {
  final MockFirebaseAuth mockAuth = MockFirebaseAuth();
  final MockUser mockUser = MockUser();

  setUp(() {});
  tearDown(() {});

  // test('create account', () async {
  //   when(
  //     mockAuth.createUser(),
  //   ).thenReturn(true);
  // });
}
