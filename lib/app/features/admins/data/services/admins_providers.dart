import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/data/services/app_providers.dart';
import 'package:gpfa_central/app/features/admins/data/services/admins_controller.dart';
import 'package:gpfa_central/app/features/admins/data/services/admins_repository.dart';

final adminRepositoryProvider = Provider(
  (ref) => AdminsRepository(firestore: ref.watch(firestoreProvider)),
);

final adminsControllerProvider = Provider(
  (ref) =>
      AdminsController(adminsRepository: ref.watch(adminRepositoryProvider)),
);

final getAllAdminsProvider = FutureProvider(
  (ref) => ref.watch(adminsControllerProvider).getAllAdmins(),
);

final getAllAdminsStreamProvider = StreamProvider(
  (ref) => ref.watch(adminsControllerProvider).getAllAdminsStream(),
);
