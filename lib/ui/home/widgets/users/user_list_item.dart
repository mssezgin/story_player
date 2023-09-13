import 'package:flutter/material.dart';
import 'package:story_player/repository/models/barrel.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
    required this.user,
    required this.onStartPlayingStories,
  });

  final User user;
  final void Function() onStartPlayingStories;

  String _getUnseenStoryCountString() {
    return user.isUnseen ? '(${user.unseenStories.length}) ' : '';
  }

  String _getLastActivityDateString() {
    Duration timeDifference = DateTime.now().difference(user.lastActivityDate);
    if (timeDifference.inHours > 0) {
      return '${timeDifference.inHours} hours ago';
    } else {
      return '${timeDifference.inMinutes} minutes ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onStartPlayingStories,
      padding: EdgeInsets.zero,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.inverseSurface,
              radius: 28,
              child: Text(
                '${user.firstName[0]}${user.lastName[0]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_getUnseenStoryCountString()}${user.fullName}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _getLastActivityDateString(),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
