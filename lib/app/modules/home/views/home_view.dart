// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sqlite/app/modules/form/controllers/form_controller.dart';
import 'package:sqlite/app/routes/app_pages.dart';

class HomeView extends GetView<FormController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.loadNote();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.loadNote(),
          builder: (context, i) {
            return Container(
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: controller.listnote.length,
                  itemBuilder: ((context, i) {
                    return GestureDetector(
                      onTap: (() {
                        Get.toNamed(Routes.FORM,
                            arguments: controller.listnote[i]);
                      }),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 226, 223, 223),
                                    spreadRadius: 2,
                                    offset: Offset(0.0, 0.0))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.listnote[i].title!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  controller.listnote[i].desc!,
                                  maxLines: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.FORM);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
