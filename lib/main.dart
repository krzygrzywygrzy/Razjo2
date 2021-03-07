import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razjo/routes/bloc/navigation_bloc.dart';
import 'package:razjo/routes/navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isWindows || Platform.isLinux || Platform.isMacOS){
    //TODO: set min size of window
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
      home: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Navigation(),
      ),
    );
  }
}
