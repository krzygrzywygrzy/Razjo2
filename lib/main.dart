import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razjo/routes/bloc/navigation_bloc.dart';
import 'package:razjo/routes/navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Razjo',
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xffeb344f),
      ),
      home: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Navigation(),
      ),
    );
  }
}
