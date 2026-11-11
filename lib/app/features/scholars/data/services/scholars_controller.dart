import 'package:flutter/foundation.dart';
import 'package:gpfa_central/app/features/scholars/data/models/scholar_model.dart';
import 'package:gpfa_central/app/features/scholars/data/services/scholars_repository.dart';
import 'package:gpfa_central/app/features/users/data/models/enums.dart';

class ScholarsController {
  final ScholarsRepository _repository;

  ScholarsController({required this._repository});

  Future<List<ScholarModel>> getAllScholar() {
    return _repository.getAllScholars();
  }

  Stream<List<ScholarModel>> watchAllScholar() {
    return _repository.watchAllScholars();
  }

  Future<void> changeStatus({
    required ApplicationStatus status,
    required String scholarId,
  }) async {
    try {
      return _repository.changeScholarStatus(
        scholarId: scholarId,
        status: status,
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
