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
    required this.controller,
  });

  final List<User> users;
  final bool isUnseenMode;
  final int currentUserIndex;
  final PageController controller;

  User get currentUser => users[currentUserIndex];

  @override
  List<Object?> get props => [
    users,
    isUnseenMode,
    currentUserIndex,
    controller,
  ];

  PlayerPlaying copyWith({
    List<User>? users,
    bool? isUnseenMode,
    int? currentUserIndex,
    PageController? controller,
  }) {
    return PlayerPlaying(
      users: users ?? this.users,
      isUnseenMode: isUnseenMode ?? this.isUnseenMode,
      currentUserIndex: currentUserIndex ?? this.currentUserIndex,
      controller: controller ?? this.controller,
    );
  }
}
