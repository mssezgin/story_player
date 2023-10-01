import 'package:flutter/material.dart';
import 'package:story_player/helpers/date_time_extension.dart';
import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/ui/common/widgets/multi_progress_indicator.dart';
import 'package:story_player/ui/common/widgets/user_profile_avatar.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
    required this.user,
    required this.onPressed,
  });

  final User user;
  final VoidCallback onPressed;

  String _getUnseenStoryCountString() {
    return user.isUnseen ? '(${user.unseenStories.length}) ' : '';
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                UserProfileAvatar(
                  user: user,
                  radius: 28,
                ),
                CircularMultiProgressIndicator(
                  maxValue: user.stories.length,
                  value: user.unseenStories.length.toDouble(),
                  backgroundColor: Colors.black26,
                  color: Colors.greenAccent.shade700, // Colors.green.shade400,
                  radius: 62,
                  strokeWidth: 2,
                ),
              ],
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
                user.lastActivityDate.toStringFromNow(),
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
