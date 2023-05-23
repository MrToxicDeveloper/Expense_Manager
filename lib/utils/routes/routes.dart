import 'package:get/get.dart';
import 'package:untitled/screens/entry/view/update_screen.dart';
import 'package:untitled/screens/view/view/view.dart';

import '../../screens/entry/view/entry_screen.dart';
import '../../screens/home/view/home_screen.dart';

class RoutesManager {
  static RoutesManager routesManager = RoutesManager._();

  RoutesManager._();

  List<GetPage> getPageList = [
    GetPage(name: '/', page: () => HomeScreen()),
    GetPage(name: '/entry', page: () => EntryScreen()),
    GetPage(name: '/update', page: () => UpdateScreen()),
    GetPage(name: '/view', page: () => ViewScreen()),
  ];
}
