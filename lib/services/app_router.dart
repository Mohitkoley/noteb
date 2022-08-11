import 'package:flutter/material.dart';
import 'package:noteb/screens/recycle_bin.dart';
import 'package:noteb/screens/task_screen.dart';

class AppRouter {
  Route? onGenrateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => const RecycleBin());
      case TaskScreen.id:
        return MaterialPageRoute(builder: (_) => TaskScreen());
      default:
        return null;
    }
  }
}
