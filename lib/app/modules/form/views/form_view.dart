// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable, avoid_print

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sqlite/app/data/note_model.dart';

import '../controllers/form_controller.dart';

class FormView extends GetView<FormController> {
  bool isnew = true;
  Note? note = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print('note $note');
    if (note != null) {
      controller.titleController.text = note?.title ?? '';
      controller.descController.text = note?.desc ?? '';
      controller.noteset = note;
      isnew = false;
    }

    Future savedata() async {
      if (isnew == true) {
        await controller.addRecord();
        controller.titleController.clear();
        controller.descController.clear();
      } else {
        await controller.updateRecord();
        controller.titleController.clear();
        controller.descController.clear();
      }
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
                decoration: InputDecoration(label: Text("Title")),
                controller: controller.titleController,
                minLines: 1,
                maxLines: 2,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(label: Text("Description")),
                controller: controller.descController,
                maxLines: 10,
                minLines: 1,
              ),
              SizedBox(height: 20),
              note == null
                  ? ElevatedButton(
                      child: Text("Submit"),
                      onPressed: () async {
                        await savedata();
                        controller.listnote.value = await controller.loadNote();
                        controller.titleController.clear();
                        controller.descController.clear();
                        Get.back();
                      })
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            child: Text("Delete"),
                            onPressed: () async {
                              await controller.deleteRecord(note!);
                              controller.listnote.value =
                                  await controller.loadNote();
                              controller.titleController.clear();
                              controller.descController.clear();
                              Get.back();
                            }),
                        ElevatedButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              await savedata();
                              controller.listnote.value =
                                  await controller.loadNote();
                              controller.titleController.clear();
                              controller.descController.clear();
                              Get.back();
                            })
                      ],
                    )
            ],
          ),
        ));
  }
}
