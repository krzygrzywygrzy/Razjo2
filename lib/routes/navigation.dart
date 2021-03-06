import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razjo/routes/bloc/navigation_bloc.dart';
import 'package:razjo/routes/pages/log_in_page/log_in_page.dart';

class Navigation extends StatelessWidget {
  BlocBuilder<NavigationBloc, NavigationState> buildApp(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        if (state is NavigationInitial) {
          context.read<NavigationBloc>().add(CheckAuthentication());
          return Center(
            child: Text("Loading..."),
          );
        }else if (state is NavigationLogIn){
          return LogInPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildApp(context),
      ),
    );
  }
}
