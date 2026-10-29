import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/services/auth_controller.dart';
import 'package:gpfa_central/app/auth/data/services/firebase_auth_repository.dart';
import 'package:gpfa_central/app/auth/data/services/firebase_auth_user_repository.dart';
import 'package:gpfa_central/app/data/services/app_providers.dart';

final firebaseAuthRepository = Provider(
  (ref) => FirebaseAuthRepository(auth: ref.watch(firebaseAuthProvider)),
);
final firebaseAuthUserRepository = Provider(
  (ref) => FirebaseAuthUserRepository(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  ),
);

final authControllerProvider = Provider(
  (ref) => AuthController(
    authRepository: ref.watch(firebaseAuthRepository),
    authUserRepository: ref.watch(firebaseAuthUserRepository),
  ),
);

final adminStreamProvider = StreamProvider(
  (ref) => ref.watch(authControllerProvider).adminStreams(),
);

final getAdminProvider = FutureProvider(
  (ref) => ref.watch(authControllerProvider).getAdmin(),
);
