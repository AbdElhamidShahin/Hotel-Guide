import 'dart:io';
import 'package:flutter/material.dart';

class CustomUserAvatar extends StatelessWidget {
  final File? currentImageFile;
  final String? imagePathOrUrl;
  final double radius;

  const CustomUserAvatar({
    super.key,
    this.currentImageFile,
    this.imagePathOrUrl,
    this.radius = 40.0,
  });

  ImageProvider _buildProfileImage() {
    if (currentImageFile != null) {
      return FileImage(currentImageFile!);
    }

    if (imagePathOrUrl != null && imagePathOrUrl!.isNotEmpty) {
      if (imagePathOrUrl!.startsWith('http')) {
        return NetworkImage(imagePathOrUrl!);
      } else {
        File file = File(imagePathOrUrl!);
        if (file.existsSync()) {
          return FileImage(file);
        }
      }
    }

    return const AssetImage('assets/images/profile.png');
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      // surfaceContainerHighest is the correct M3 slot for a placeholder
      // surface that needs to stand out from the background in both modes.
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      backgroundImage: _buildProfileImage(),
    );
  }
}