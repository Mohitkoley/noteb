import 'package:flutter/material.dart';
import 'package:noteb/screens/recycle_bin.dart';
import 'package:noteb/screens/tabs_screen.dart';
import 'package:noteb/screens/pending_screen.dart';

class AppRouter {
  Route? onGenrateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => const RecycleBin());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => const TabsScreen());
      default:
        return null;
    }
  }
}
