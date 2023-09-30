import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/ui/player/pages/barrel.dart';

part 'story_group_event.dart';
part 'story_group_state.dart';

class StoryGroupBloc extends Bloc<StoryGroupEvent, StoryGroupState> {
  StoryGroupBloc({
    required User user,
    required PlayerBloc playerBloc,
  })  : _user = user,
        _playerBloc = playerBloc,
        super(const StoryGroupLoading()) {
    on<StoryGroupPlay>(_onStoryGroupPlay);
    on<StoryGroupPreviousStory>(_onStoryGroupPreviousStory);
    on<StoryGroupNextStory>(_onStoryGroupNextStory);
  }

  final User _user;
  final PlayerBloc _playerBloc;

  void _onStoryGroupPlay(StoryGroupPlay event, Emitter<StoryGroupState> emit) {
    int firstUnseenStoryIndex = _user.firstUnseenStoryIndex;
    emit(
      StoryGroupSuccess(
        user: _user,
        isUnseenMode: event.isUnseenMode,
        currentStoryIndex: event.isUnseenMode
            ? firstUnseenStoryIndex == -1
                ? _user.stories.length - 1
                : firstUnseenStoryIndex
            : 0,
      ),
    );
  }

  void _onStoryGroupPreviousStory(StoryGroupPreviousStory event, Emitter<StoryGroupState> emit) {
    StoryGroupState state = this.state;
    if (state is StoryGroupSuccess) {

      int previousStoryIndex = state.currentStoryIndex - 1;
      if (previousStoryIndex >= 0) {
        emit(state.copyWith(
          currentStoryIndex: previousStoryIndex,
        ));
        return;
      }

      _playerBloc.add(const PlayerPreviousUser(
        isControlled: true,
      ));
    }
  }

  void _onStoryGroupNextStory(StoryGroupNextStory event, Emitter<StoryGroupState> emit) {
    StoryGroupState state = this.state;
    if (state is StoryGroupSuccess) {

      int nextStoryIndex = state.currentStoryIndex + 1;
      if (nextStoryIndex < state.user.stories.length) {
        emit(state.copyWith(
          currentStoryIndex: nextStoryIndex,
        ));
        return;
      }

      _playerBloc.add(const PlayerNextUser(
        isControlled: true,
      ));
    }
  }

  @override
  void onEvent(StoryGroupEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }

  @override
  void onTransition(Transition<StoryGroupEvent, StoryGroupState> transition) {
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
