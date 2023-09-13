part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object?> get props => [];
}

class PlayerInitial extends PlayerState {
  const PlayerInitial();
}

class PlayerLoading extends PlayerState {
  const PlayerLoading();
}

class PlayerPlaying extends PlayerState {
  const PlayerPlaying({
    required this.users,
    required this.isUnseenMode,
    required this.currentUserIndex,
    required this.currentStoryIndex,
  });

  final List<User> users;
  final bool isUnseenMode;
  final int currentUserIndex;
  final int currentStoryIndex;

  User get currentUser => users[currentUserIndex];

  Story get currentStory => currentUser.stories[currentStoryIndex];

  @override
  List<Object?> get props => [
    users,
    isUnseenMode,
    currentUserIndex,
    currentStoryIndex,
  ];
}

class PlayerPaused extends PlayerState {
  const PlayerPaused();
}
