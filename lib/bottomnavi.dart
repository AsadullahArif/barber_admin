import 'package:barberapp_admin/widgets/tabs/menuview.dart';
import 'package:barberapp_admin/widgets/tabs/tab1.dart';
import 'package:barberapp_admin/widgets/tabs/tab2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  late List<Widget> tabs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    tabs = [
      Tab1( firestore: _firestore,),
       Tab2(),
       const MenuViewer(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: CommonColors.colorBlueShade1,
        // unselectedItemColor: CommonColors.colorWhiteShade1,
        // selectedItemColor: CommonColors.colorRedShade1,
        selectedIconTheme: const IconThemeData(
          // size: ScreenConstant.size34,
        ),
        // selectedLabelStyle: TextStyles.textStyleSemiBold16,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: "APPOINTMENTS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: "DASHBOARDS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: "LISTINGS",
          ),
        ],
      ),
    );
  }
}
