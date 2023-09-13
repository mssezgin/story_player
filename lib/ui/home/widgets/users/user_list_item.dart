import 'package:flutter/material.dart';
import 'package:story_player/repository/models/barrel.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
    required this.user,
    required this.onPressed,
  });

  final User user;
  final VoidCallback onPressed;

  String _getUnseenStoryCountString() {
    return '(${user.unseenStories.length}/${user.stories.length}) ';
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
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(9),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: Theme.of(context).colorScheme.primary,
                  style: user.isUnseen ?  BorderStyle.solid : BorderStyle.none,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                radius: 28,
                child: Text(
                  user.fullNameInitials,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
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
