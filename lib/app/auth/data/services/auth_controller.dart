import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/auth/data/services/firebase_auth_repository.dart';
import 'package:gpfa_central/app/auth/data/services/firebase_auth_user_repository.dart';

class AuthController {
  final FirebaseAuthRepository _authRepository;
  final FirebaseAuthUserRepository _authUserRepository;

  AuthController({
    required this._authRepository,
    required this._authUserRepository,
  });

  Future<Admin?> signupWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    final user = await _authRepository.signupWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (user == null) return null;
    final isDbEmpty = await _authUserRepository.isDbEmpty();
    if (isDbEmpty == null) return null;

    Admin? admin;
    if (isDbEmpty) {
      admin = await _authUserRepository.requestAdminAccess(
        user: user,
        name: name,
        role: .superadmin,
      );
    } else {
      admin = await _authUserRepository.requestAdminAccess(
        name: name,
        user: user,
        role: .unverified,
      );
    }
    if (admin == null) return null;
    return _authUserRepository.getAdmin();
  }

  Future<Admin?> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = await _authRepository.signinWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (user == null) return null;
    return _authUserRepository.getAdmin();
  }

  Stream<Admin?> adminStreams() {
    return _authUserRepository.getAdminStream();
  }

  Future<Admin?> getAdmin() async {
    return await _authUserRepository.getAdmin();
  }

  Future<void> signout() async {
    return _authRepository.signout();
  }
}
