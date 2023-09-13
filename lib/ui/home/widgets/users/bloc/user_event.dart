part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserGenerateRandomList extends UserEvent {
  const UserGenerateRandomList();
}

class UserGetById extends UserEvent {
  const UserGetById({required this.userId});

  final int userId;

  @override
  List<Object?> get props => [userId];
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
