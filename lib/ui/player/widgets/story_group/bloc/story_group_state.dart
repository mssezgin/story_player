part of 'story_group_bloc.dart';

class StoryGroupState extends Equatable {
  const StoryGroupState();

  @override
  List<Object?> get props => [];
}

class StoryGroupLoading extends StoryGroupState {
  const StoryGroupLoading();
}

class StoryGroupSuccess extends StoryGroupState {
  const StoryGroupSuccess({
    required this.user,
    required this.isUnseenMode,
    required this.currentStoryIndex,
  });

  final User user;
  final bool isUnseenMode;
  final int currentStoryIndex;

  Story get currentStory => user.stories[currentStoryIndex];

  @override
  List<Object?> get props => [
        user,
        currentStoryIndex,
      ];

  StoryGroupSuccess copyWith({
    User? user,
    bool? isUnseenMode,
    int? currentStoryIndex,
  }) {
    return StoryGroupSuccess(
      user: user ?? this.user,
      isUnseenMode: isUnseenMode ?? this.isUnseenMode,
      currentStoryIndex: currentStoryIndex ?? this.currentStoryIndex,
    );
  }
}

class StoryGroupError extends StoryGroupState {
  const StoryGroupError({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
