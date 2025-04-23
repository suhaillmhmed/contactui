import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String place;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String photopath;

  StudentModel(
      {required this.name,
      this.id,
      required this.place,
      required this.phone,
      required this.photopath});
}
