import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/features/admins/data/services/admins_repository.dart';

class AdminsController {
  final AdminsRepository _adminsRepository;

  AdminsController({required this._adminsRepository});

  Future<List<Admin>> getAllAdmins() async {
    return _adminsRepository.getAllAdmins();
  }

  Stream<List<Admin>> getAllAdminsStream() {
    return _adminsRepository.getAllAdminsStream();
  }

  Future<void> confirmAdmin({required String adminId}) async {
    return _adminsRepository.confirmAdmin(adminId: adminId);
  }

  Future<void> deleteAdmin({required String adminId}) async {
    return _adminsRepository.deleteAdmin(adminId: adminId);
  }
  Future<void> suspendAdmin({required String adminId}) async {
    return _adminsRepository.suspendAdmin(adminId: adminId);
  }

  Future<void> rejectAdmin({required String adminId}) async {
    return _adminsRepository.rejectAdmin(adminId: adminId);
  }
}
