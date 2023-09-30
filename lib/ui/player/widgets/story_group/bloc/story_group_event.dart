part of 'story_group_bloc.dart';

class StoryGroupEvent extends Equatable {
  const StoryGroupEvent();

  @override
  List<Object?> get props => [];
}

class StoryGroupPlay extends StoryGroupEvent {
  const StoryGroupPlay({
    required this.isUnseenMode,
  });

  final bool isUnseenMode;

  @override
  List<Object?> get props => [isUnseenMode];
}

class StoryGroupPreviousStory extends StoryGroupEvent {
  const StoryGroupPreviousStory();
}

class StoryGroupNextStory extends StoryGroupEvent {
  const StoryGroupNextStory();
}
