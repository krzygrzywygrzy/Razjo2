import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:razjo/models/user.dart';

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
      //TODO: implement
    }
  }
}
