import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barberapp_admin/widgets/controllers/dashboardController.dart';

class Tab2 extends StatelessWidget {
final DashboardController controller = Get.put(DashboardController());
  Tab2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("DASHBOARD",style: TextStyle(fontWeight: FontWeight.bold),)),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
            child: Column(
              children: <Widget>[
                // const SizedBox(
                //   height: 20,
                // ),
                Stack(children: [
                  Image.asset("assets/earning.png"),
                  Positioned(
                    top: 10,
                    left: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                          "₹ ${controller.currentRate.value}",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        )),
                        const Text(
                          "Total Earnings",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )),
                ]),
                const SizedBox(
                  height: 20,
                ),
                Stack(children: [
                  Image.asset("assets/profile.png"),
                  Positioned(
                    left: 70,
                    top: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                          " ${controller.currentUsersCount.value}",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        )),
                        const Text(
                          'Total Users',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ]),
                  ),
                ]),
                const SizedBox(
                  height: 20,
                ),
                // Stack(children: [
                //   Image.asset("assets/download.png"),
                //   const Positioned(
                //     top: 10,
                //     left: 70,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //          Text(
                //           "20",
                //           style: TextStyle(
                //             fontSize: 30,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white),
                //         ),
                //         Text(
                //           "Downloads",
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 15,
                //           ),
                //         ),
                //       ],
                //     )),
                // ]),
                const SizedBox(
                  height: 20,
                ),
                Stack(children: [
                  Image.asset("assets/appointment.png"),
                  Positioned(
                    top: 10,
                    left: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                          "${controller.currentAppointmentsCount.value}",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        )),
                        const Text(
                          "Appointments ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
