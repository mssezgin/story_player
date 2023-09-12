import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/repository/barrel.dart';
import 'package:story_player/repository/models/barrel.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserInitial()) {
    on<UserGetAll>(_onUserGetAll);
    on<UserGetAllWithAllStories>(_onUserGetAllWithAllStories);
    on<UserGetAllWithUnseenStories>(_onUserGetAllWithUnseenStories);
  }

  final UserRepository _userRepository;

  Future<void> _onUserGetAll(UserGetAll event, Emitter<UserState> emit) async {
    emit(const UserLoading());
    try {
      List<User> allUsers = await _userRepository.getAllUsers();
      emit(UserSuccess(users: allUsers));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      emit(UserError(errorMessage: error.toString()));
    }
  }

  Future<void> _onUserGetAllWithAllStories(UserGetAllWithAllStories event, Emitter<UserState> emit) async {
    emit(const UserLoading());
    try {
      List<User> allUsers = await _userRepository.getAllUsersWithAllStories();
      emit(UserSuccess(users: allUsers));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      emit(UserError(errorMessage: error.toString()));
    }
  }

  Future<void> _onUserGetAllWithUnseenStories(UserGetAllWithUnseenStories event, Emitter<UserState> emit) async {
    emit(const UserLoading());
    try {
      List<User> unseenUsers = await _userRepository.getAllUsersWithUnseenStories();
      emit(UserSuccess(users: unseenUsers));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      emit(UserError(errorMessage: error.toString()));
    }
  }

  @override
  void onEvent(UserEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }

  @override
  void onTransition(Transition<UserEvent, UserState> transition) {
    super.onTransition(transition);
    debugPrint(transition.toString());
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugPrint(error.toString());
    debugPrint(stackTrace.toString());
  }
}
