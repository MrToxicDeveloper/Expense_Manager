import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/utils/routes/routes.dart';

void main() {
  runApp(

    Sizer(
      builder: (context, orientation, deviceType) => Theme(
        data: ThemeData(fontFamily: 'Roboto'),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: RoutesManager.routesManager.getPageList,
        ),
      ),
    ),
  );
}
