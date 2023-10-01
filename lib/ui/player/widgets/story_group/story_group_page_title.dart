import 'package:flutter/material.dart';
import 'package:story_player/helpers/date_time_extension.dart';
import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/ui/common/widgets/user_profile_avatar.dart';

class StoryGroupPageTitle extends StatelessWidget {
  const StoryGroupPageTitle({
    super.key,
    required this.user,
    required this.currentStory,
  });

  final User user;
  final Story currentStory;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        UserProfileAvatar(
          user: user,
          radius: 20,
        ),
        const SizedBox(width: 12),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.fullName),
            const SizedBox(height: 2),
            Text(
              currentStory.sharedDate.toStringFromNow(short: false),
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
