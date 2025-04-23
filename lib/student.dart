import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_contactui9/functions.dart';
import 'package:flutter_application_contactui9/model.dart';
import 'package:image_picker/image_picker.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 61, 59, 59),
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemGrey,
        title: const Text(
          'Add Student',
          style: TextStyle(color: Color.fromARGB(255, 66, 225, 164)),
        ),
        centerTitle: true,
      ),      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: imagePath != null
                  ? FileImage(File(imagePath!.path))
                  : NetworkImage(
                      'https://th.bing.com/th/id/R.6b0022312d41080436c52da571d5c697?rik=ejx13G9ZroRrcg&riu=http%3a%2f%2fpluspng.com%2fimg-png%2fuser-png-icon-young-user-icon-2400.png&ehk=NNF6zZUBr0n5i%2fx0Bh3AMRDRDrzslPXB0ANabkkPyv0%3d&risl=&pid=ImgRaw&r=0'),
            ),
            const SizedBox(
              height: 14,
            ),
            ElevatedButton(
                onPressed: () {
                  getImage();
                },
                child: const Text('Add photo')),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: placeController,
                decoration: const InputDecoration(
                    hintText: 'Place',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                    hintText: 'Mobile',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                final data = StudentModel(
                    name: nameController.text,
                    place: placeController.text,
                    phone: phoneController.text,
                    photopath: imagePath!.path);

                print(data.name);
                await addStudent(data);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.teal[400]),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
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
