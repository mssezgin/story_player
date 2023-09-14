import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/repository/barrel.dart';
import 'package:story_player/repository/models/barrel.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const PlayerInitial()) {
    on<PlayerPlay>(_onPlayerPlay);
    on<PlayerStop>(_onPlayerStop);
  }

  final UserRepository _userRepository;

  Future<void> _onPlayerPlay(PlayerPlay event, Emitter<PlayerState> emit) async {
    emit(const PlayerLoading());

    List<User> users = event.isUnseenMode
        ? await _userRepository.getAllUsersWithUnseenStories()
        : await _userRepository.getAllUsersWithAllStories();

    if (users.isEmpty) {
      emit(const PlayerInitial());
    } else {
      emit(
        PlayerPlaying(
          users: users,
          isUnseenMode: event.isUnseenMode,
          currentUserIndex: event.startUserIndex,
          currentStoryIndex: event.isUnseenMode
              ? users[event.startUserIndex].firstUnseenStoryIndex
              : 0,
          controller: PageController(
            initialPage: event.startUserIndex,
          ),
          userControllers: users
              .map((user) => PageController(
                    initialPage: event.isUnseenMode ? user.firstUnseenStoryIndex : 0,
                  ))
              .toList(),
        ),
      );
    }
  }

  void _onPlayerStop(PlayerStop event, Emitter<PlayerState> emit) {
    emit(const PlayerInitial());
  }

  @override
  void onEvent(PlayerEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }

  @override
  void onTransition(Transition<PlayerEvent, PlayerState> transition) {
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
