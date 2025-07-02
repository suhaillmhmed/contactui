import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_contactui9/functions.dart';
import 'package:flutter_application_contactui9/main.dart';
import 'package:flutter_application_contactui9/model.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_application_contactui9/model.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen(
      {super.key,
      required this.name,
      required this.place,
      required this.phoneNumber,
      required this.photoPath,
      required this.index});

  final String name;
  final String place;
  final String phoneNumber;
  final String photoPath;
  final int index;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  File? imagePath;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    TextEditingController editNameController =
        TextEditingController(text: widget.name);
    TextEditingController editPlaceController =
        TextEditingController(text: widget.place);
    TextEditingController editPhoneController =
        TextEditingController(text: widget.phoneNumber);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 61, 59, 59),
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemGrey,
        title: const Text(
          'Edit Student',
          style: TextStyle(color: Color.fromARGB(255, 66, 225, 164)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.person_circle_fill,
                color: Colors.white,
                size: 90,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: const Text('Edit Photo')),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.025),
                child: TextFormField(
                  controller: editNameController,
                  decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.025),
                child: TextFormField(
                  controller: editPlaceController,
                  decoration: const InputDecoration(
                      hintText: 'Place',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.025),
                child: TextFormField(
                  controller: editPhoneController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final data = StudentModel(
                        name: editNameController.text,
                        place: editPlaceController.text,
                        phone: editPhoneController.text,
                        photopath: imagePath!.path);
                    editStudent(widget.index, data);
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[600]),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void getImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) return;
    setState(() {
      imagePath = File(img.path);
    });
  }
}
