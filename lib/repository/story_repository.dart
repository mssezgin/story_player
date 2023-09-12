import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/repository/services/barrel.dart';

class StoryRepository {
  StoryRepository({
    required StoryService storyService,
    required UserService userService,
  })  : _storyService = storyService,
        _userService = userService;

  final StoryService _storyService;
  final UserService _userService;

  Future<Story> getStoryOfUserById(int userId, int id) async {
    User user = await _userService.getUserById(userId);
    return user.stories.firstWhere((story) => story.id == id);
  }

  Future<List<Story>> getAllStoriesOfUser(int userId) async {
    User user = await _userService.getUserById(userId);
    return user.stories;
  }

  Future<List<Story>> getAllUnseenStoriesOfUser(int userId) async {
    User user = await _userService.getUserById(userId);
    return user.stories.where((story) => story.isUnseen).toList();
  }

  Future<void> updateStoryOfUserMarkSeen(int userId, int id) async {
    User user = await _userService.getUserById(userId);
    Story story = user.stories.firstWhere((story) => story.id == id);
    story.isUnseen = false;
  }
}
