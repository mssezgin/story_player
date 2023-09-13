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

class PlayerNextStory extends PlayerEvent {
  const PlayerNextStory();
}

class PlayerNextUser extends PlayerEvent {
  const PlayerNextUser();
}

class PlayerPause extends PlayerEvent {
  const PlayerPause();
}

class PlayerResume extends PlayerEvent {
  const PlayerResume();
}

class PlayerStop extends PlayerEvent {
  const PlayerStop();
}
