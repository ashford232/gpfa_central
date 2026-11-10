import 'package:gpfa_central/app/features/users/data/models/user_model.dart';
import 'package:gpfa_central/app/features/users/data/services/user_repository.dart';

class UserController {
  final UserRepository _repository;

  UserController({required this._repository});
  Future<List<UserModel>> getAllUsers() {
    return _repository.getAllUsers();
  }
  Future<UserModel?> getUser({required String userId}) {
    return _repository.getUser(userId:userId);
  }
 Stream<UserModel?> watchUser({required String userId}) {
    return _repository.watchUser(userId:userId);
  }

  Stream<List<UserModel>> watchAllUsers() {
    return _repository.watchAllUsers();
  }
}
