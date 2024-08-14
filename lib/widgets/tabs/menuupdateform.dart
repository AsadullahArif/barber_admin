// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuForm extends StatefulWidget {
  final String? initialName;
  final String? initialPrice;

  const MenuForm({super.key, this.initialName, this.initialPrice});

  @override
  _MenuFormState createState() => _MenuFormState();
}

class _MenuFormState extends State<MenuForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _priceController = TextEditingController(text: widget.initialPrice?.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      height:200,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Item Price'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a price';
                }
                return null;
              },
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    ),
                  onPressed: () {
                      Navigator.pop(context); // Close the form
                  },
                  child: const Text('Cancel',
                  ),
                ),
                ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Submit the form, either for adding or updating
                  final itemName = _nameController.text;
                  final itemPrice = int.parse(_priceController.text);
    
                  // Call the appropriate function based on the action  update
                   {
                    // Update existing menu item
                    updateMenuItem(itemName, itemPrice.toString());
                  }
    
                  Navigator.pop(context); // Close the form
                }
              },
              child: const Text('Save'),
            ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}

// Function to update an existing menu item
Future<void> updateMenuItem(String name, String price) async {
  final CollectionReference menuCollection = FirebaseFirestore.instance.collection('Services');
  final QuerySnapshot querySnapshot = await menuCollection.where('Title', isEqualTo: name).get();

  if (querySnapshot.docs.isNotEmpty) {
    final DocumentSnapshot menuItem = querySnapshot.docs.first;
    await menuCollection.doc(menuItem.id).update({'Rate': price});
  }
}
