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
    on<PlayerPreviousStory>(_onPlayerPreviousStory);
    on<PlayerNextStory>(_onPlayerNextStory);
    on<PlayerStop>(_onPlayerStop);
  }

  final UserRepository _userRepository;
  final Curve storyTransitionCurve = Curves.linear;
  final Duration storyTransitionDuration = const Duration(milliseconds: 1);
  final Curve storyGroupTransitionCurve = Curves.easeInOut;
  final Duration storyGroupTransitionDuration = const Duration(milliseconds: 500);

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

  void _onPlayerPreviousStory(PlayerPreviousStory event, Emitter<PlayerState> emit) {
    PlayerState state = this.state;
    if (state is PlayerPlaying) {

      int previousStoryIndex = state.currentStoryIndex - 1;
      if (previousStoryIndex >= 0) {
        state.currentUserController.previousPage(
          duration: storyTransitionDuration,
          curve: storyTransitionCurve,
        );
        emit(state.copyWith(
          currentStoryIndex: previousStoryIndex,
        ));
        return;
      }

      int previousUserIndex = state.currentUserIndex - 1;
      if (previousUserIndex >= 0) {
        state.controller.previousPage(
          duration: storyGroupTransitionDuration,
          curve: storyGroupTransitionCurve,
        );
        emit(state.copyWith(
          currentUserIndex: previousUserIndex,
          // TODO: currentStoryIndex might be taken from relevant page controller
          currentStoryIndex: state.isUnseenMode
              ? state.users[previousUserIndex].firstUnseenStoryIndex
              : 0,
        ));
        return;
      }

      add(const PlayerStop());
    }
  }

  void _onPlayerNextStory(PlayerNextStory event, Emitter<PlayerState> emit) {
    PlayerState state = this.state;
    if (state is PlayerPlaying) {

      int nextStoryIndex = state.currentStoryIndex + 1;
      if (nextStoryIndex < state.currentUser.stories.length) {
        state.currentUserController.nextPage(
          duration: storyTransitionDuration,
          curve: storyTransitionCurve,
        );
        emit(state.copyWith(
          currentStoryIndex: nextStoryIndex,
        ));
        return;
      }

      int nextUserIndex = state.currentUserIndex + 1;
      if (nextUserIndex < state.users.length) {
        state.controller.nextPage(
          duration: storyGroupTransitionDuration,
          curve: storyGroupTransitionCurve,
        );
        emit(state.copyWith(
          currentUserIndex: nextUserIndex,
          // TODO: currentStoryIndex might be taken from relevant page controller
          currentStoryIndex: state.isUnseenMode
              ? state.users[nextUserIndex].firstUnseenStoryIndex
              : 0,
        ));
        return;
      }

      add(const PlayerStop());
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
    PlayerState nextState = transition.nextState;
    if (nextState is PlayerPlaying) {
      nextState.currentStory.markSeen();
    }
    debugPrint(transition.toString());
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugPrint(error.toString());
    debugPrint(stackTrace.toString());
  }
}
