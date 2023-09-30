part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object?> get props => [];
}

class PlayerPlay extends PlayerEvent {
  const PlayerPlay({
    required this.isUnseenMode,
    required this.startUserIndex,
  });

  final bool isUnseenMode;
  final int startUserIndex;

  @override
  List<Object?> get props => [
        isUnseenMode,
        startUserIndex,
      ];
}

class PlayerPreviousUser extends PlayerEvent {
  const PlayerPreviousUser({
    required this.isControlled,
  });

  final bool isControlled;

  @override
  List<Object?> get props => [isControlled];
}

class PlayerNextUser extends PlayerEvent {
  const PlayerNextUser({
    required this.isControlled,
  });

  final bool isControlled;

  @override
  List<Object?> get props => [isControlled];
}

class PlayerStop extends PlayerEvent {
  const PlayerStop();
}
