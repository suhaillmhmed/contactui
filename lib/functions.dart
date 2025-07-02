import 'package:flutter/cupertino.dart';
import 'package:flutter_application_contactui9/model.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<StudentModel>> valueNotifier = ValueNotifier([]);

const dbName = 'studentDB';

Future<void> addStudent(StudentModel data) async {
  final db = await Hive.openBox<StudentModel>(dbName);
  final id = await db.add(data);
  data.id = id;
  valueNotifier.value.add(data);
  await getData();
  valueNotifier.notifyListeners();
}

Future<void> getData() async {
  final db = await Hive.openBox<StudentModel>(dbName);
  valueNotifier.value.clear();
  valueNotifier.value.addAll(db.values);
  valueNotifier.notifyListeners();
}

Future<void> editStudent(int index, StudentModel data) async {
  final db = await Hive.openBox<StudentModel>(dbName);
  db.putAt(index, data);
  getData();
}

Future<void> deleteStiudent(int index) async {
  final db = await Hive.openBox<StudentModel>(dbName);
  db.deleteAt(index);
  getData();
}
