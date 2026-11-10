import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/data/services/app_providers.dart';
import 'package:gpfa_central/app/features/scholars/data/services/scholars_controller.dart';
import 'package:gpfa_central/app/features/scholars/data/services/scholars_repository.dart';

final scholarRepositoryProvider = Provider(
  (ref) => ScholarsRepository(firestore: ref.watch(firestoreProvider)),
);
final scholarControllerProvider = Provider(
  (ref) => ScholarsController(repository: ref.watch(scholarRepositoryProvider)),
);

final watchAllScholarsProvider = StreamProvider(
  (ref) => ref.watch(scholarControllerProvider).watchAllScholar(),
);
final getAllScholarsProvider = FutureProvider(
  (ref) => ref.watch(scholarControllerProvider).getAllScholar(),
);

