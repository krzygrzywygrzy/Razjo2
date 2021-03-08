import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razjo/routes/bloc/navigation_bloc.dart';
import 'package:razjo/routes/navigation.dart';
import 'package:razjo/routes/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle("");
    setWindowMinSize(const Size(1035, 555));
  }
  runApp(MyApp());
}

//Min window size: width 1035, height 555,

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Razjo',
      theme: ThemeData(
        primaryColor: Color(0xffeb344f),
        fontFamily: 'Poppins',
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(),
          ),
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(),
          )
        ],
        child: Navigation(),
      ),
    );
  }
}
