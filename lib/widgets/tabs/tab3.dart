// ignore_for_file: unnecessary_import, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tab3 extends StatelessWidget {
  const Tab3({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(child: ServiceForm()),
      );
  }
}

class ServiceForm extends StatefulWidget {
  const ServiceForm({super.key});

  @override
  _ServiceFormState createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _includedController = TextEditingController();
  final TextEditingController _descriptionImageController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                fillColor: Color.fromARGB(255, 248, 225, 211),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide.none),
                hintText: "Title",
                // labelText: 'Title'
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            child: TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  fillColor: Color.fromARGB(255, 248, 225, 211),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide.none),
                  hintText: "Description"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            child: TextFormField(
              controller: _rateController,
              decoration: const InputDecoration(
                  // contentPadding: EdgeInsets.all(10)
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none),
                  fillColor: Color.fromARGB(255, 248, 225, 211),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none),
                  hintText: 'Rate'),
              // keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a rate';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            child: TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none),
                  fillColor: Color.fromARGB(255, 248, 225, 211),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none),
                  hintText: 'Image URL'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            child: TextFormField(
              controller: _includedController,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none),
                  fillColor: Color.fromARGB(255, 248, 225, 211),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none),
                  hintText: 'Included Services'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            child: TextFormField(
              controller: _descriptionImageController,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none),
                  fillColor: Color.fromARGB(255, 248, 225, 211),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none),
                  hintText: 'Description Image'),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 10)),
                  // textStyle: MaterialStateProperty.all(
                  //   const TextStyle(fontSize: 30),
                  // ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveService();
                  }
                },
                child: const Text(
                  'Add Service',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.black),
                ),
              ),
            ),
          ),
          // Container(

          // )
        ],
      ),
    );
  }

  void _saveService() {
    FirebaseFirestore.instance.collection('Services').add({
      'Title': _titleController.text,
      'Description': _descriptionController.text??"",
      'Rate': _rateController.text,
      'Image': _imageUrlController.text??"",
      'Included': _includedController.text??"",
      'desImage': _descriptionImageController.text??"",
    }).then((value) {
      // Clear form fields after saving
      _titleController.clear();
      _descriptionController.clear();
      _rateController.clear();
      _imageUrlController.clear();
      _includedController.clear();
      _descriptionImageController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Service added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add service: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }
}
