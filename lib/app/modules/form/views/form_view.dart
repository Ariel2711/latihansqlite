// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable, avoid_print

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sqlite/app/data/user_model.dart';

import '../controllers/form_controller.dart';

class FormView extends GetView<FormController> {
  bool isnew = true;
  User? user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print('user $user');
    if (user != null) {
      controller.usernameController.text = user?.username ?? '';
      controller.passwordController.text = user?.password ?? '';
      controller.roleController.text = user?.role ?? '';
      controller.userset = user;
      isnew = false;
    }

    Future savedata() async {
      if (isnew == true) {
        await controller.addRecord();
      } else {
        await controller.updateRecord();
      }
      controller.listuser.value = await controller.loadUser();
      controller.usernameController.clear();
      controller.passwordController.clear();
      controller.roleController.clear();
      Get.back();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Form'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(label: Text("Username")),
                controller: controller.usernameController,
                minLines: 1,
                maxLines: 2,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(label: Text("Password")),
                controller: controller.passwordController,
                maxLines: 10,
                minLines: 1,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(label: Text("Role")),
                controller: controller.roleController,
                maxLines: 10,
                minLines: 1,
              ),
              SizedBox(height: 20),
              user == null
                  ? ElevatedButton(
                      child: Text("Submit"),
                      onPressed: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.none) {
                          print('internet connection not available');
                          await savedata();
                        } else {
                          await controller.addRecordApi();
                          controller.usernameController.clear();
                          controller.passwordController.clear();
                          controller.roleController.clear();
                          Get.back();
                        }
                      })
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            child: Text("Delete"),
                            onPressed: () async {
                              await controller.deleteRecord(user!);
                              controller.listuser.value =
                                  await controller.loadUser();
                              controller.usernameController.clear();
                              controller.passwordController.clear();
                              controller.roleController.clear();
                              Get.back();
                            }),
                        ElevatedButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              await savedata();
                            })
                      ],
                    )
            ],
          ),
        ));
  }
}
