// ignore_for_file: library_private_types_in_public_api, unnecessary_import, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widgets/tabs/tab1.dart';
import 'widgets/tabs/tab2.dart';
import 'widgets/tabs/tab3.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      // 8115544524
      child: Scaffold(
        // drawer: Drawer(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 100),
        //     child: InkWell(
        //         onTap: () {
        //           Get.to(() => const Dashboard());
        //         },
        //         child: const Text("Dashboard")),
        //   ),
        // ),
        // appBar: AppBar(
        //   title: const Text(
        //     'Admin Panel',
        //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: true,
        // ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text("ADMINPANEL",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8)),
                    child: const TabBar(
                      labelStyle: TextStyle(
                        fontSize: 11,
                        fontWeight:FontWeight.bold,
                        color: Colors.white
                      ),
                      unselectedLabelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color.fromARGB(255, 252, 162, 27),
                      ),
                      tabs: [
                        Tab(
                          text: "APPOINTMENTS",
                        ),
                        Tab(
                          text: "DASHBOARDS",
                        ),
                        Tab(
                          text: "LISTINGS",),
                      ],
                    ),
                  ),
                ),
              ),
               Expanded(
                child: TabBarView(children: [
                Tab1(firestore: firestore),
                Tab2(),
                const Tab3(),
                  
                ]),
              ),
           
            ],
          ),
        ),
      ),
    );
  }
}


