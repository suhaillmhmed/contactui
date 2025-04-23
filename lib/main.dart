import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_contactui9/edit.dart';
import 'package:flutter_application_contactui9/model.dart';
import 'package:flutter_application_contactui9/student.dart';
import 'package:flutter_application_contactui9/functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? imagepath;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 61, 59, 59),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemGrey,
        title: Text(
          'Home Screen',
          style: TextStyle(color: const Color.fromARGB(255, 66, 225, 164)),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        
        valueListenable: valueNotifier,
        builder: (context, studentlist, child) {
          print('${studentlist.length}');
          return ListView.builder(
            itemCount: studentlist.length,
            itemBuilder: (context, index) {
              final student = studentlist[index];
              return Padding(
                padding: EdgeInsets.all(8),
                child: Card(
                  color: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(CupertinoIcons.person_alt_circle),
                        radius: 50,
                      ),
                      title: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.grey[800],
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      CupertinoIcons.person_circle_fill,
                                      color: Colors.white,
                                      size: 100,
                                    ),
                                    SizedBox(height: 25),
                                    Row(
                                      children: [
                                        Text(
                                          '   Name:',
                                          style: TextStyle(
                                              color: Colors.teal[400]),
                                        ),
                                        Text(
                                          student.name,
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          '   Place:',
                                          style: TextStyle(
                                              color: Colors.teal[400]),
                                        ),
                                        Text(
                                          student.place,
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          '   phone:',
                                          style: TextStyle(
                                              color: Colors.teal[400]),
                                        ),
                                        Text(
                                          student.phone,
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          student.name,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold, 
                            color: const Color.fromARGB(255, 66, 225, 164),
                          ),
                        ),
                      ),
                      subtitle: Text(
                        student.place,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 245, 21, 5)),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ThirdScreen(
                                      name: student.name,
                                      place: student.place,
                                      photoPath: student.photopath,
                                      phoneNumber: student.phone,
                                      index: index,
                                    ),
                                  ));
                            },
                            child: Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 66, 225, 164),
                            ),
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 245, 21, 5),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.grey[800],
                                    title: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Do you want to delete this\n               student',
                                            style: TextStyle(
                                                color: Colors.teal[400],
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 60),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeScreen(),
                                                      ),
                                                      (route) => false,
                                                    );
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    deleteStiudent(index);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 66, 225, 164),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SecondScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}