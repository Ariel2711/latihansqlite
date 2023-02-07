import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqlite/app/data/note_model.dart';
import 'package:sqlite/app/data/sqlite.dart';

class FormController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  RxList<Note> listnote = <Note>[].obs;
  Note? noteset;
  var db = DatabaseHelper();

  Future<List<Note>> loadNote() async {
    return listnote.value = await db.getNote();
  }

  Future addRecord() async {
    var note = Note(titleController.text, descController.text);
    await db.saveNote(note);
  }

  Future updateRecord() async {
    var note = Note(titleController.text, descController.text);
    note.setNoteid(noteset!.id!);
    await db.updateNote(note);
  }

  Future deleteRecord(Note note) async {
    db.deleteNote(note);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    loadNote();
    super.onInit();
  }
}
