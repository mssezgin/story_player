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
    required this.controller,
    required this.userControllers,
  });

  final List<User> users;
  final bool isUnseenMode;
  final int currentUserIndex;
  final int currentStoryIndex;
  final PageController controller;
  final List<PageController> userControllers;

  User get currentUser => users[currentUserIndex];

  PageController get currentUserController => userControllers[currentUserIndex];

  Story get currentStory => currentUser.stories[currentStoryIndex];

  @override
  List<Object?> get props => [
    users,
    isUnseenMode,
    currentUserIndex,
    currentStoryIndex,
    controller,
    userControllers,
  ];

  PlayerPlaying copyWith({
    List<User>? users,
    bool? isUnseenMode,
    int? currentUserIndex,
    int? currentStoryIndex,
    PageController? controller,
    List<PageController>? userControllers,
  }) {
    return PlayerPlaying(
      users: users ?? this.users,
      isUnseenMode: isUnseenMode ?? this.isUnseenMode,
      currentUserIndex: currentUserIndex ?? this.currentUserIndex,
      currentStoryIndex: currentStoryIndex ?? this.currentStoryIndex,
      controller: controller ?? this.controller,
      userControllers: userControllers ?? this.userControllers,
    );
  }
}

class PlayerPaused extends PlayerState {
  const PlayerPaused();
}
