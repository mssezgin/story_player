import 'package:flutter/material.dart';
import 'package:story_player/repository/models/barrel.dart';

class UserProfileAvatar extends StatelessWidget {
  const UserProfileAvatar({
    super.key,
    required this.user,
    required this.radius,
  });

  final User user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    String? profileImageSource = user.profileImageSource;
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      foregroundImage: profileImageSource != null
          ? NetworkImage(profileImageSource)
          : null,
      child: Text(
        user.fullNameInitials,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
