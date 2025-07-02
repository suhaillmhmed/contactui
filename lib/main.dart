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
  runApp(const MyApp());
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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemGrey,
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Color.fromARGB(255, 66, 225, 164)),
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
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Card(
                  color: Colors.grey[800],
                  child: Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: screenWidth * 0.10,
                        child: const Icon(CupertinoIcons.person_alt_circle),
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
                                    const Icon(
                                      CupertinoIcons.person_circle_fill,
                                      color: Colors.white,
                                      size: 100,
                                    ),
                                    SizedBox(height: screenHeight * 0.03),
                                    Row(
                                      children: [
                                        Text(
                                          '   Name:',
                                          style: TextStyle(
                                              color: Colors.teal[400]),
                                        ),
                                        Flexible(
                                          child: Text(
                                            student.name,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.015),
                                    Row(
                                      children: [
                                        Text(
                                          '   Place:',
                                          style: TextStyle(
                                              color: Colors.teal[400]),
                                        ),
                                        Flexible(
                                          child: Text(
                                            student.place,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.015),
                                    Row(
                                      children: [
                                        Text(
                                          '   phone:',
                                          style: TextStyle(
                                              color: Colors.teal[400]),
                                        ),
                                        Flexible(
                                          child: Text(
                                            student.phone,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ),
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
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 66, 225, 164),
                          ),
                        ),
                      ),
                      subtitle: Text(
                        student.place,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 245, 21, 5)),
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
                            child: const Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 66, 225, 164),
                            ),
                          ),
                          GestureDetector(
                            child: const Icon(
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
                                                fontSize: screenWidth * 0.04),
                                          ),
                                          SizedBox(height: screenHeight * 0.08),
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
                                                            const HomeScreen(),
                                                      ),
                                                      (route) => false,
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    deleteStiudent(index);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
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
        backgroundColor: const Color.fromARGB(255, 66, 225, 164),
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
