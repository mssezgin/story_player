import 'dart:math';

import 'package:story_player/repository/models/barrel.dart';

class UserService {
  UserService() : _allUsers = UserService._defaultUsers;

  static final List<User> _defaultUsers = [
    User(
      id: 101,
      username: 'user.1',
      firstName: 'First',
      lastName: 'User',
      lastActivityDate: DateTime.now().subtract(const Duration(hours: 3)),
      stories: [],
    ),
    User(
      id: 102,
      username: 'user.2',
      firstName: 'Second',
      lastName: 'User',
      lastActivityDate: DateTime.now().subtract(const Duration(minutes: 30)),
      stories: [],
    ),
    User(
      id: 103,
      username: 'user.3',
      firstName: 'Third',
      lastName: 'User',
      lastActivityDate: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      stories: [],
    ),
    User(
      id: 104,
      username: 'user.4',
      firstName: 'Fourth',
      lastName: 'User',
      lastActivityDate: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      stories: [],
    ),
    User(
      id: 105,
      username: 'user.5',
      firstName: 'Fifth',
      lastName: 'User',
      lastActivityDate: DateTime.now().subtract(const Duration(minutes: 1)),
      stories: [],
    ),
    User(
      id: 106,
      username: 'user.6',
      firstName: 'Sixth',
      lastName: 'User',
      lastActivityDate: DateTime.now().subtract(const Duration(hours: 2)),
      stories: [],
    ),
    User(
      id: 107,
      username: 'user.7',
      firstName: 'Seventh',
      lastName: 'User',
      lastActivityDate: DateTime.now().subtract(const Duration(minutes: 45)),
      stories: [],
    ),
    User(
      id: 108,
      username: 'user.8',
      firstName: 'Eighth',
      lastName: 'User',
      lastActivityDate: DateTime.now().subtract(const Duration(hours: 12)),
      stories: [],
    ),
  ];

  static const List<String> _firstNames = [
    'Galileo',
    'Isaac',
    'Albert',
    'Charles',
    'Marie',
    'Stephan',
    'Nikola',
    'Thomas',
    'Johannes',
    'Rosalind',
    'Louis',
    'Michael',
    'Nicolaus',
    'Leonardo',
    'James',
    'Max',
  ];

  static const List<String> _lastNames = [
    'Galilei',
    'Newton',
    'Einstein',
    'Darwin',
    'Curie',
    'Hawking',
    'Tesla',
    'Edison',
    'Kepler',
    'Franklin',
    'Pasteur',
    'Faraday',
    'Copernicus',
    'da Vinci',
    'Chadwick',
    'Planck',
  ];

  static List<User> _generateRandomUsers(int userCount) {
    Random random = Random();
    return List<User>.generate(
      userCount,
      (index) {
        int storyCount = random.nextInt(8) + 1;
        int seenStoryCount = random.nextInt(storyCount + 1);
        List<Story> stories = UserService._generateRandomStories(index, storyCount, seenStoryCount);
        return User(
          id: index,
          username: 'user.${index.toRadixString(16)}',
          firstName: UserService._firstNames[random.nextInt(UserService._firstNames.length)],
          lastName: UserService._lastNames[random.nextInt(UserService._lastNames.length)],
          lastActivityDate: stories
              .map((story) => story.sharedDate)
              .fold(
                DateTime.fromMillisecondsSinceEpoch(0),
                (date1, date2) => date1.isBefore(date2) ? date2 : date1
              ),
          stories: stories,
        );
      },
    );
  }

  static List<Story> _generateRandomStories(int userId, int storyCount, int seenStoryCount) {
    Random random = Random();
    List<Story> stories = List<Story>.generate(
      storyCount,
      (index) {
        return Story(
          id: userId * 100 + index,
          userId: userId,
          sharedDate: DateTime.now().subtract(
            Duration(minutes: random.nextInt(Duration.minutesPerDay)),
          ),
          // TODO: story type should be random
          storyType: StoryType.image,
          // TODO: file source should be random according to story type
          fileSource: 'https://picsum.photos/${random.nextInt(1080)}/${random.nextInt(2160)}',
          // TODO: duration should be 5 seconds or video length
          duration: const Duration(seconds: 5),
          isUnseen: true,
        );
      },
    );
    UserService._sortStories(stories);
    stories.take(seenStoryCount).forEach((story) => story.markSeen());
    return stories;
  }

  static void _sortUsers(List<User> users) {
    users.sort((user1, user2) {
      bool user1IsUnseen = user1.isUnseen;
      bool user2IsUnseen = user2.isUnseen;
      if (user1IsUnseen == user2IsUnseen) {
        return user2.lastActivityDate.compareTo(user1.lastActivityDate);
      }
      if (user1IsUnseen) {
        return -1;
      }
      return 1;
    });
  }

  static void _sortStories(List<Story> stories) {
    stories.sort((story1, story2) {
      return story1.sharedDate.compareTo(story2.sharedDate);
    });
  }

  List<User> _allUsers;

  Future<void> fillUserListRandomly() async {
    Random random = Random();
    int userCount = random.nextInt(16) + 1;
    _allUsers = UserService._generateRandomUsers(userCount);
    UserService._sortUsers(_allUsers);
  }

  Future<User> getUserById(int id) async {
    return _allUsers.firstWhere((user) => user.id == id);
  }

  Future<List<User>> getAllUsers() async {
    return _allUsers;
  }

  Future<List<User>> getAllUsersWithAllStories() async {
    return _allUsers.where((user) => user.stories.isNotEmpty).toList();
  }

  Future<List<User>> getAllUsersWithUnseenStories() async {
    return _allUsers
        .where((user) => user.stories.isNotEmpty)
        .where((user) => user.stories.any((story) => story.isUnseen))
        .toList();
  }
}
