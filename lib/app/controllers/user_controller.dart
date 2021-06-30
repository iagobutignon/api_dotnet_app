import 'package:api_dotnet_app/app/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserController with ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
