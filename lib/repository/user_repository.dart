import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/repository/services/barrel.dart';

class UserRepository {
  UserRepository({required UserService userService})
      : _userService = userService;

  final UserService _userService;

  Future<void> fillUserListRandomly() async {
    await _userService.fillUserListRandomly();
  }

  Future<User> getUserById(int id) async {
    return await _userService.getUserById(id);
  }

  Future<List<User>> getAllUsers() async {
    return await _userService.getAllUsers();
  }

  Future<List<User>> getAllUsersWithAllStories() async {
    return await _userService.getAllUsersWithAllStories();
  }

  Future<List<User>> getAllUsersWithUnseenStories() async {
    return await _userService.getAllUsersWithUnseenStories();
  }
}
