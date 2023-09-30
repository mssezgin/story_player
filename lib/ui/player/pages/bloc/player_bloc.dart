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
    on<PlayerPreviousUser>(_onPlayerPreviousUser);
    on<PlayerNextUser>(_onPlayerNextUser);
    on<PlayerStop>(_onPlayerStop);
  }

  final UserRepository _userRepository;
  final Curve storyGroupTransitionCurve = Curves.easeInOut;
  final Duration storyGroupTransitionDuration = const Duration(milliseconds: 500);

  Future<void> _onPlayerPlay(PlayerPlay event, Emitter<PlayerState> emit) async {
    emit(const PlayerLoading());

    List<User> users = event.isUnseenMode
        ? await _userRepository.getAllUsersWithUnseenStories()
        : await _userRepository.getAllUsersWithAllStories();

    if (users.isEmpty) {
      add(const PlayerStop());
    } else {
      emit(
        PlayerPlaying(
          users: users,
          isUnseenMode: event.isUnseenMode,
          currentUserIndex: event.startUserIndex,
          controller: PageController(
            initialPage: event.startUserIndex,
          ),
        ),
      );
    }
  }

  void _onPlayerPreviousUser(PlayerPreviousUser event, Emitter<PlayerState> emit) {
    PlayerState state = this.state;
    if (state is PlayerPlaying) {

      int previousUserIndex = state.currentUserIndex - 1;
      if (previousUserIndex >= 0) {
        if (event.isControlled) {
          state.controller.previousPage(
            duration: storyGroupTransitionDuration,
            curve: storyGroupTransitionCurve,
          );
        }
        emit(state.copyWith(
          currentUserIndex: previousUserIndex,
        ));
        return;
      }

      add(const PlayerStop());
    }
  }

  void _onPlayerNextUser(PlayerNextUser event, Emitter<PlayerState> emit) {
    PlayerState state = this.state;
    if (state is PlayerPlaying) {

      int nextUserIndex = state.currentUserIndex + 1;
      if (nextUserIndex < state.users.length) {
        if (event.isControlled) {
          state.controller.nextPage(
            duration: storyGroupTransitionDuration,
            curve: storyGroupTransitionCurve,
          );
        }
        emit(state.copyWith(
          currentUserIndex: nextUserIndex,
        ));
        return;
      }

      add(const PlayerStop());
    }
  }

  void _onPlayerStop(PlayerStop event, Emitter<PlayerState> emit) {
    PlayerState state = this.state;
    if (state is PlayerPlaying) {
      state.controller.dispose();
    }
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
