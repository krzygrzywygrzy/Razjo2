import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:razjo/core/erros/failures.dart';

import '../../models/user.dart';
import '../../services/authentication_service.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial());
  User _user = User();
  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is CheckAuthentication) {
      if (_user.id == null)
        yield NavigationLogIn(failure: null);
      else
        yield NavigationDashboard(user: _user);
    }
    //log in screen
    if (event is GoToLogInScreen) yield NavigationLogIn(failure: null);

    if (event is LogInEvent) {
      yield NavigationLoading();
      AuthenticationService auth = AuthenticationService();
      Either response = await auth.userLogin(event.email, event.password);
      if (response.isRight()) {
        _user = response.getOrElse(() => _user);
        yield NavigationDashboard(user: _user);
      } else {
        yield NavigationLogIn(failure: (response as Left).value);
      }
    }

    //sign up page
    if (event is GoToSignUpScreen) yield NavigationSignUp(failure: null);

    if (event is SignUpEvent) {
      yield NavigationLoading();
      AuthenticationService auth = AuthenticationService();
      Either response = await auth.userSignUp(event.user);
      if (response.isRight()) {
        _user = response.getOrElse(() => _user);
        yield NavigationDashboard(user: _user);
      } else {
        yield NavigationSignUp(failure: (response as Left).value);
      }
    }

    if (event is LogOutEvent) {
      _user = User();
      yield NavigationLogIn();
    }
  }
}
