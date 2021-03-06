import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:razjo/models/user.dart';
import 'package:razjo/services/authentication_service.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial());

  User user = User();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if(event is CheckAuthentication){
     if(user.token == null)
       yield NavigationLogIn();
    }
    if(event is LogInEvent){
      yield NavigationLoading();
      AuthenticationService auth = AuthenticationService();
      Either response = await auth.userLogin(event.login, event.password);
      if(response.isRight())
        yield NavigationDashboard();
    }
  }
}
