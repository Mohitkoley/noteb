import 'package:flutter/material.dart';
import 'package:noteb/blocs/bloc_export.dart';
import 'package:noteb/model/app_router.dart';

import 'package:noteb/screens/task_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
      storage: storage,
      () => runApp(MyApp(
            appRouter: AppRouter(),
          )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TaskScreen(),
        onGenerateRoute: appRouter.onGenrateRoute,
      ),
    );
  }
}
