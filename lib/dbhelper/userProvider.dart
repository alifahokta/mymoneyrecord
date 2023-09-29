import 'package:flutter/foundation.dart';
import 'package:mymoneyrecord/dbhelper/dbHelper.dart';
import 'package:mymoneyrecord/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final DbHelper dbHelper = DbHelper();

  User? get user => _user;

  Future<void> fetchUserByUsername(String username) async {
    final user = await dbHelper.getUserByUsername(username);
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }
}
