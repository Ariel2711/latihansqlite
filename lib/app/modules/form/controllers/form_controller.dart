import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqlite/app/data/apiservice.dart';
import 'package:sqlite/app/data/user_model.dart';
import 'package:sqlite/app/data/sqlite.dart';

class FormController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  RxList<User> listuser = <User>[].obs;
  RxList<User> listuserapi = <User>[].obs;
  User? userset;
  var db = DatabaseHelper();

  final ApiService api = ApiService();

  Future<List<User>> loadUserApi() async {
    return listuserapi.value = await api.getUsers();
  }

  Future addRecordApi() async {
    var user = User(
        usernameController.text, passwordController.text, roleController.text);
    await api.createUser(user);
  }

  Future<List<User>> loadUser() async {
    return listuser.value = await db.getUsers();
  }

  Future addRecord() async {
    var user = User(
        usernameController.text, passwordController.text, roleController.text);
    await db.saveUser(user);
  }

  Future updateRecord() async {
    var user = User(
        usernameController.text, passwordController.text, roleController.text);
    user.setUserid(userset!.id!);
    await db.updateUser(user);
  }

  Future deleteRecord(User user) async {
    db.deleteUser(user);
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  void onInit() {
    loadUser();
    super.onInit();
  }
}
