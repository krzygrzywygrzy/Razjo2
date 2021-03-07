import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razjo/routes/pages/dashboard/bloc/dashboard_bloc.dart';

class Dashbaord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context)=> DashboardBloc(),
      child: Center(),
    );
  }
}
