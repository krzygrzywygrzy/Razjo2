import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/navigation_bloc.dart';
import 'pages/dashboard/dashboard.dart';
import 'pages/log_in_page/log_in_page.dart';
import 'pages/sign_up_page/sign_up_page.dart';

class Navigation extends StatelessWidget {
  BlocBuilder<NavigationBloc, NavigationState> buildApp(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is NavigationInitial) {
          context.read<NavigationBloc>().add(CheckAuthentication());
          return Container();
        } else if (state is NavigationLogIn) {
          return LogInPage(
            failure: state.failure,
          );
        } else if (state is NavigationLoading) {
          return Center(
            child: Text("loading..."),
          );
        } else if (state is NavigationDashboard) {
          return Dashboard(
            user: state.user,
          );
        } else if (state is NavigationSignUp) {
          return SignUpPage(
            failure: state.failure,
          );
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
