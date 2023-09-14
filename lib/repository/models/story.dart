enum StoryType {
  image,
  video,
}

class Story {
  Story({
    required this.id,
    required this.userId,
    required this.sharedDate,
    this.isUnseen = true,
    this.duration = const Duration(seconds: 5),
    required this.storyType,
    required this.fileSource,
  });

  final int id;
  final int userId;
  final DateTime sharedDate;
  bool isUnseen;
  Duration duration;
  final StoryType storyType;
  final String fileSource;

  void markSeen() {
    isUnseen = false;
  }
}
