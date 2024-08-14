import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'menuupdateform.dart';
import 'tab3.dart';

class MenuViewer extends StatefulWidget {
  const MenuViewer({super.key});

  @override
  State<MenuViewer> createState() => _MenuViewerState();
}

class _MenuViewerState extends State<MenuViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: CommonColors.colorRedShade1,
        title: const Text('Menu'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          // backgroundColor: CommonColors.colorRedShade1,
          tooltip: "add Youtube link",
          onPressed: () {
            showBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(20.0),
                  height: 600.0,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Add Menu Item',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(height: 20.0),
                      // Replace Tab3() with your custom widget
                      Expanded(child: Tab3()),
                    ],
                  ),
                );
              },
            );
          }, 
            label: const Text('Add Menu Item'),
          ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Services').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final menus = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: ListView.builder(
                itemCount: menus.length,
                itemBuilder: (context, index) {
                  final menu = menus[index].data() as Map<String, dynamic>;
                  final menuName = menu['Title'] ?? '';
                  final menuPayment = menu['Rate'] ?? '';
                  return Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Card(
                      // color: isDarkTheme(context)
                      //     ? CommonColors.colorGreyShade3
                      //     : CommonColors.colorRedShade2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      shadowColor: Colors.blueGrey.shade900,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    "Services: $menuName",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    // style: TextStyles.textStyleSemiBold18
                                    //     .copyWith(
                                    //         color:
                                    //             CommonColors.colorWhiteShade1),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Payment: ₹$menuPayment",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  // style: TextStyles.textStyleSemiBold16
                                  //     .copyWith(
                                  //         color:
                                  //             CommonColors.colorWhiteShade1),
                                ),
                              ],
                            ),
                            // Show the menu form when adding a new item
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                // backgroundColor:isDarkTheme(context)? CommonColors.colorBlackShade1:CommonColors.colorWhiteShade1,side: const BorderSide(color: CommonColors.colorRedShade1,width: 1.5,)
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Update Menu Item'),
                                      content: MenuForm(
                                        initialName: menuName,
                                        initialPrice: menuPayment,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Update Menu Item',
                                // style: TextStyles.textStyleSemiBold16.copyWith(color: isDarkTheme(context)?CommonColors.colorWhiteShade1:CommonColors.colorBlackShade1,)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
