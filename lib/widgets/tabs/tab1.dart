// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:barberapp_admin/widgets/customLoader.dart';

class Tab1 extends StatefulWidget {
  const Tab1({
    super.key,
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  late String _fcmToken;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  void _getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      setState(() {
        _fcmToken = token;
      });
      print('FCM Token: $_fcmToken');
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          actions: [
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'New'),
              Tab(text: 'Completed'),
              Tab(text: 'Pending'),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: _selectedDate != null
                  ? Text(
                      "Selected Date is : ${DateFormat("dd-MM-yyyy").format(_selectedDate!)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : Text(
                      "Today Date is : ${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AppointmentsList(
                    category: 'New',
                    selectedDate: _selectedDate,
                  ),
                  AppointmentsList(
                    category: 'Completed',
                    selectedDate: _selectedDate,
                  ),
                  AppointmentsList(
                    category: 'Pending',
                    selectedDate: _selectedDate,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentsList extends StatelessWidget {
  const AppointmentsList(
      {super.key, required this.category, this.selectedDate});

  final String category;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    var date = selectedDate != null
        ? DateFormat("yyyy-MM-dd").format(selectedDate!)
        : DateFormat("yyyy-MM-dd").format(DateTime.now());

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: firestore
          .collection('Appointments')
          .doc(date)
          .collection("slots")
          .where('status', isEqualTo: category)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoader();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return ListView(
          children: snapshot.data!.docs.map((appointment) {
            var appointmentData = appointment.data() as Map<String, dynamic>;
            var uid = appointmentData['uid'];
            return FutureBuilder(
              future: firestore
                  .collection('Users')
                  .where("uid", isEqualTo: uid)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.done) {
                  var userData = userSnapshot.data!.docs.first.data()
                      as Map<String, dynamic>?;
                  var userName = userData != null && userData['Name'] != null
                      ? userData['Name']
                      : 'Unknown';
                  // var appointmentTimestamp = appointmentData['date'] ;
                  // DateTime appointmentDate = appointmentTimestamp.toDate();
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Customer : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '$userName',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Service : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '${appointmentData['service']}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Time : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '${appointmentData['time']}',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Date : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  date,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Price : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  "${appointmentData['rate']}",
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Amount to be paid : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  "${appointmentData['cashAfterService']}",
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                if (category == 'New') {
                                  _moveToPending(firestore,
                                      appointmentData['time'], date, uid);
                                } else if (category == 'Pending') {
                                  _markAsCompleted(firestore,
                                      appointmentData['time'], date, uid);
                                }
                              },
                              child: Text(
                                category == 'New'
                                    ? 'Accept'
                                    : category == 'Pending'
                                        ? 'Pending'
                                        : 'Done',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: category == 'New'
                                      ? Colors.green
                                      : category == 'Pending'
                                          ? Colors.amber
                                          : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                }
                return const CustomLoader();
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _moveToPending(FirebaseFirestore firestore, String appointmentId,
      String date, String uid) {
    firestore
        .collection('Appointments')
        .doc(date)
        .collection("slots")
        .doc(appointmentId)
        .update({'status': 'Pending'})
        .then((_) => print('Appointment moved to pending'))
        .catchError((error) => print('Failed to move appointment: $error'));
    firestore
        .collection('Users')
        .doc(uid)
        .collection("Appointments")
        .doc(appointmentId)
        .update({'status': 'Pending'})
        .then((_) => print('Appointment moved to pending'))
        .catchError((error) => print('Failed to move appointment: $error'));
  }

  void _markAsCompleted(FirebaseFirestore firestore, String appointmentId,
      String date, String uid) {
    firestore
        .collection('Users')
        .doc(uid)
        .collection('Appointments')
        .doc(appointmentId)
        .update({'status': 'Completed'})
        .then((_) => print('Appointment marked as completed'))
        .catchError((error) =>
            print('Failed to mark appointment as completed: $error'));
    firestore
        .collection('Appointments')
        .doc(date)
        .collection("slots")
        .doc(appointmentId)
        .update({'status': 'Completed'})
        .then((_) => print('Appointment marked as completed'))
        .catchError((error) =>
            print('Failed to mark appointment as completed: $error'));
  }
}
