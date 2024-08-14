// ignore_for_file: file_names

import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  DashboardController get insatnce => Get.find();

  final RxInt appointmentsCount = 0.obs;
  final RxInt usersCount = 0.obs; 
  final RxInt currentAppointmentsCount = 0.obs;
  final RxInt currentUsersCount = 0.obs;
  final RxInt totalRate = 0.obs;
  final RxInt currentRate = 0.obs;
  late Timer appointmentsTimer;
  late Timer usersTimer;
  late Timer rateTimer;

  @override
  void onInit() {
    super.onInit();
    fetchCounts();
  }

  void appointments() {
    appointmentsTimer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (currentAppointmentsCount.value < appointmentsCount.value) {
        currentAppointmentsCount.value++;
      } else {
        timer.cancel();
      }
    });
  }

  void users() {
    usersTimer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (currentUsersCount.value < usersCount.value) {
        currentUsersCount.value++;
      } else {
        timer.cancel();
      }
    });
  }

  void rate() {
    rateTimer = Timer.periodic(const Duration(milliseconds: 5), (timer) {
      if (currentRate.value < totalRate.value) {
        currentRate.value++;
      } else {
        timer.cancel();
      }
    });
  }

  void fetchCounts() async {
    final appointmentsSnapshot = await FirebaseFirestore.instance.collection('Appointments').doc(DateFormat("yyyy-MM-dd").format(DateTime.now())).collection("slots").get();
    final usersSnapshot = await FirebaseFirestore.instance.collection('Users').get();
    final totalRateSnapshot = await FirebaseFirestore.instance.collection('Appointments').doc(DateFormat("yyyy-MM-dd").format(DateTime.now())).collection("slots").where('status',isEqualTo:'Completed' ).get();

    appointmentsCount.value = appointmentsSnapshot.size;
    usersCount.value = usersSnapshot.size;

    int sum = 0;
    for (var doc in totalRateSnapshot.docs) {
      sum += (doc['rate'] as int);
    }
    totalRate.value = sum;

    appointments();
    users();
    rate();
  }
}
