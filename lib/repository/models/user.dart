import 'package:story_player/repository/models/barrel.dart';

class User {
  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.lastActivityDate,
    this.stories = const [],
  });

  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final DateTime lastActivityDate;
  final List<Story> stories;
}
