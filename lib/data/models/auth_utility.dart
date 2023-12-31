import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_model.dart';
import 'package:get_storage/get_storage.dart';

class AuthUtility{

  AuthUtility._();
  static LoginModel userInfo = LoginModel();

  static Future<void> saveUserInfo(LoginModel model) async{
   // ReadWriteValue('user-data', jsonEncode(model.toJson()));
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('user-data',jsonEncode(model.toJson()));
    userInfo = model;
    }

  static Future<void> updateUserInfo(UserData data) async{
   // ReadWriteValue('user-data', jsonEncode(userInfo.toJson()), () => GetStorage());
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    userInfo.data = data;
    await _sharedPreferences.setString('user-data',jsonEncode(userInfo.toJson()));
  }


  static Future<LoginModel> getUserInfo() async{
   // String age = 0.val('user-data') as String;
     SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
     String value = _sharedPreferences.getString('user-data')!;
     return LoginModel.fromJson(jsonDecode(value));
  }

  static Future<void> clearUserInfo() async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  await _sharedPreferences.clear();

   }

  static Future<bool> checkIfUserLoggedIn() async{
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    bool isLogin =  _sharedPreferences.containsKey('user-data');
    if(isLogin){
      userInfo = await getUserInfo();
    }
     return isLogin;
   }
}