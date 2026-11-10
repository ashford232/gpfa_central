import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/data/services/app_providers.dart';
import 'package:gpfa_central/app/features/users/data/models/user_model.dart';
import 'package:gpfa_central/app/features/users/data/services/user_controller.dart';
import 'package:gpfa_central/app/features/users/data/services/user_repository.dart';

final userControllerProvider = Provider(
  (ref) => UserController(repository: ref.watch(userRepositoryProvider)),
);
final userRepositoryProvider = Provider(
  (ref) => UserRepository(firestore: ref.watch(firestoreProvider)),
);
final watchAllUsersProvider = StreamProvider(
  (ref) => ref.watch(userControllerProvider).watchAllUsers(),
);
final getAllUsersProvider = FutureProvider(
  (ref) => ref.watch(userControllerProvider).getAllUsers(),
);

final watchUserProvider = StreamProvider.family<UserModel?, String>(
  (ref, userId) => ref.watch(userControllerProvider).watchUser(userId: userId),
);
final getUserProvider = FutureProvider.family<UserModel?, String>(
  (ref, userId) => ref.watch(userControllerProvider).getUser(userId: userId),
);
