import 'package:gpfa_central/app/features/scholars/data/models/scholar_model.dart';
import 'package:gpfa_central/app/features/scholars/data/services/scholars_repository.dart';

class ScholarsController {
  final ScholarsRepository _repository;

  ScholarsController({required this._repository});

  Future<List<ScholarModel>> getAllScholar() {
    return _repository.getAllScholars();
  }

  Stream<List<ScholarModel>> watchAllScholar() {
    return _repository.watchAllScholars();
  }
}
