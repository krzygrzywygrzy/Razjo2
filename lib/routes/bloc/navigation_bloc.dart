import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:razjo/models/user.dart';
import 'package:razjo/services/authentication_service.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial());
  User _user = User();
  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    // redirecting to log in screen or dashboard according to data existance
    if(event is CheckAuthentication){
      //TODO: check for data in shared preferences
     if(_user.token == null)
       yield NavigationLogIn();
     else yield NavigationDashboard(user: _user);
    }
    //log in screen
    if(event is GoToLogInScreen)
      yield NavigationLogIn();

    if(event is LogInEvent){
      yield NavigationLoading();
      AuthenticationService auth = AuthenticationService();
      Either response = await auth.userLogin(event.login, event.password);
      if(response.isRight())
        _user = response.getOrElse(() => _user);
        yield NavigationDashboard(user: _user);
    }

    //sign up page
    if(event is GoToSignUpScreen)
      yield NavigationSignUp();

  }
}
