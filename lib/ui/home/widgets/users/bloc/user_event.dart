part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserGetById extends UserEvent {
  const UserGetById({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}

class UserGetAll extends UserEvent {
  const UserGetAll();
}

class UserGetAllWithAllStories extends UserEvent {
  const UserGetAllWithAllStories();
}

class UserGetAllWithUnseenStories extends UserEvent {
  const UserGetAllWithUnseenStories();
}
