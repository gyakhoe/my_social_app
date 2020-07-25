import 'package:my_social_app/app_firebase/data/repositories/firebase_repository.dart';
import 'package:my_social_app/user/data/models/user.dart';

class SearchRepository {
  Future<List<User>> getAllUsers() async {
    return await FirebaseRepository().fetchUsers();
  }
}
