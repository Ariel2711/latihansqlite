// ignore_for_file: avoid_print, import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sqlite/app/data/user_model.dart';

class ApiService {
  String apiUrl =
      Platform.isAndroid ? "http://192.168.1.28:5000" : "http://localhost:5000";

  Future<List<User>> getUsers() async {
    print(apiUrl);

    final res = await http.get(Uri.parse('$apiUrl/users'));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<User> listuser =
          body.map((dynamic item) => User.fromJsonApi(item)).toList();
      return listuser;
    } else {
      throw "Failed to load user list";
    }
  }

  Future<User> getUserById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a user');
    }
  }

  Future<void> createUser(String username, password, role) async {
    Map data = {'username': username, 'password': password, 'role': role};

    print(data);

    var response = await http.post(
      Uri.parse('$apiUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return print("success");
    } else {
      throw Exception('Failed to post User');
    }
  }

  // Future<User> updateUser(String id, User user) async {
  //   Map data = {
  //     'username': user.username,
  //     'password': user.password,
  //     'role': user.role
  //   };

  //   var response = await http.put(
  //     Uri.parse('$apiUrl/$id'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(data),
  //   );
  //   if (response.statusCode == 200) {
  //     return User.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to update a user');
  //   }
  // }

  // Future<void> deleteUser(String id) async {
  //   var res = await http.delete(Uri.parse('$apiUrl/$id'));

  //   if (res.statusCode == 200) {
  //     print("user deleted");
  //   } else {
  //     throw "Failed to delete a user.";
  //   }
  // }
}
