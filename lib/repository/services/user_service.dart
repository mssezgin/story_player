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
      profileImageSource: null,
      lastActivityDate: DateTime.now().subtract(const Duration(hours: 3)),
      stories: [],
    ),
    User(
      id: 102,
      username: 'user.2',
      firstName: 'Second',
      lastName: 'User',
      profileImageSource: null,
      lastActivityDate: DateTime.now().subtract(const Duration(minutes: 30)),
      stories: [],
    ),
    User(
      id: 103,
      username: 'user.3',
      firstName: 'Third',
      lastName: 'User',
      profileImageSource: null,
      lastActivityDate: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      stories: [],
    ),
    User(
      id: 104,
      username: 'user.4',
      firstName: 'Fourth',
      lastName: 'User',
      profileImageSource: null,
      lastActivityDate: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      stories: [],
    ),
    User(
      id: 105,
      username: 'user.5',
      firstName: 'Fifth',
      lastName: 'User',
      profileImageSource: null,
      lastActivityDate: DateTime.now().subtract(const Duration(minutes: 1)),
      stories: [],
    ),
    User(
      id: 106,
      username: 'user.6',
      firstName: 'Sixth',
      lastName: 'User',
      profileImageSource: null,
      lastActivityDate: DateTime.now().subtract(const Duration(hours: 2)),
      stories: [],
    ),
    User(
      id: 107,
      username: 'user.7',
      firstName: 'Seventh',
      lastName: 'User',
      profileImageSource: null,
      lastActivityDate: DateTime.now().subtract(const Duration(minutes: 45)),
      stories: [],
    ),
    User(
      id: 108,
      username: 'user.8',
      firstName: 'Eighth',
      lastName: 'User',
      profileImageSource: null,
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

  static const String _profileImageSourceBase = 'https://randomuser.me/api/portraits/med';

  static const String _imageSourceBase = 'https://picsum.photos';

  static const List<String> _videoSources = [
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
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
          profileImageSource: random.nextBool()
              ? UserService._generateRandomProfileImageSource()
              : null,
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
        StoryType storyType = StoryType.values[random.nextInt(StoryType.values.length)];
        return Story(
          id: userId * 100 + index,
          userId: userId,
          sharedDate: DateTime.now().subtract(
            Duration(minutes: random.nextInt(Duration.minutesPerDay)),
          ),
          storyType: storyType,
          fileSource: switch (storyType) {
            StoryType.image => UserService._generateRandomImageSource(),
            StoryType.video => UserService._generateRandomVideoSource(),
          },
          duration: switch (storyType) {
            StoryType.image => const Duration(seconds: 5),
            StoryType.video => const Duration(seconds: 0),
          },
          isUnseen: true,
        );
      },
    );
    UserService._sortStories(stories);
    stories.take(seenStoryCount).forEach((story) => story.markSeen());
    return stories;
  }

  static String _generateRandomProfileImageSource() {
    Random random = Random();
    return '${UserService._profileImageSourceBase}/${random.nextBool() ? 'men' : 'women'}/${random.nextInt(90)}.jpg';
  }

  static String _generateRandomImageSource() {
    Random random = Random();
    return '${UserService._imageSourceBase}/${random.nextInt(480) + 720 - 480}/${random.nextInt(640) + 1280 - 640}';
  }

  static String _generateRandomVideoSource() {
    Random random = Random();
    return UserService._videoSources[random.nextInt(UserService._videoSources.length)];
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
    UserService._sortUsers(_allUsers);
    return _allUsers;
  }

  Future<List<User>> getAllUsersWithAllStories() async {
     List<User> allUsersWithAllStories = _allUsers.where((user) => user.stories.isNotEmpty).toList();
     UserService._sortUsers(allUsersWithAllStories);
     return allUsersWithAllStories;
  }

  Future<List<User>> getAllUsersWithUnseenStories() async {
    List<User> allUsersWithUnseenStories = _allUsers
        .where((user) => user.stories.isNotEmpty)
        .where((user) => user.stories.any((story) => story.isUnseen))
        .toList();
    UserService._sortUsers(allUsersWithUnseenStories);
    return allUsersWithUnseenStories;
  }
}
