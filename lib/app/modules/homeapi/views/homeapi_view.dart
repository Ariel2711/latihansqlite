import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sqlite/app/data/apiservice.dart';
import 'package:sqlite/app/data/user_model.dart';
import 'package:sqlite/app/modules/form/controllers/form_controller.dart';
import 'package:sqlite/app/routes/app_pages.dart';

class HomeapiView extends GetView<FormController> {
  final ApiService api = ApiService();

  HomeapiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data API'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.loadUserApi(),
          builder: (context, i) {
            return controller.listuserapi.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: UsersList(controller.listuserapi),
                  )
                : Center(
                    child: Text('No data found, tap plus button to add!',
                        style: Theme.of(context).textTheme.bodyMedium));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.FORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  const UsersList(this.users, {super.key});
  final List<User> users;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users == <User>[] ? 0 : users.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ListTile(
            leading: const Icon(Icons.person),
            title: Text(users[index].username!),
            subtitle: Text(users[index].role!),
          ));
        });
  }
}
