// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barberapp_admin/widgets/customSize.dart';
// import 'package:barberapp_admin/widgets/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class CustomLoader extends StatefulWidget {
  final Color color;
  final Color? bgColor;
  final bool isCompact;

  const CustomLoader({
    super.key,
    this.color = Colors.yellow,
    this.bgColor,
    this.isCompact = false,
  });

  @override
  _CustomLoaderState createState() => _CustomLoaderState();

  void stopLoading() {
    // Navigator.of(Get.overlayContext!).pop();
    Get.back();
  }
}

class _CustomLoaderState extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.isCompact ? null : MediaQuery.of(context).size.height,
      width: widget.isCompact ? null : MediaQuery.of(context).size.width,
      // color: widget.bgColor ?? (isDarkTheme(context)
      //     ? Colors.black
      //     : Colors.white),
      child: Center(
          child: Container(
              constraints: BoxConstraints(
                maxHeight: ScreenConstant.size80,
                maxWidth: ScreenConstant.size80,
                minHeight: ScreenConstant.size60,
                minWidth: ScreenConstant.size60,
              ),
              child: Center(
                child: SpinKitFadingCircle(
                  duration: const Duration(milliseconds: 1300),
                  color: widget.color,
                  size: ScreenConstant.size60,
                ),
              ))),
    );
  }
    }
