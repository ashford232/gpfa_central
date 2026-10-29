import 'package:flutter/material.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/shared/ui/app_cached_image.dart';
import 'package:gpfa_central/shared/utls/extensions.dart';
import 'package:gpfa_central/shared/utls/resources.dart';

Widget buildAdminAvatar({
  required Admin admin,
  double? width,
  double? height,
  double? borderRadius,
}) {
  if (admin.avatar.isNotEmpty) {
    return AppCachedImage(
      url: admin.avatar,
      width: width ?? 50,
      height: height ?? 50,
      borderRadius: borderRadius != null
          ? BorderRadius.circular(borderRadius)
          : null,
    );
  }

  return Container(
    width: width ?? 30,
    height: height ?? 30,
    decoration: BoxDecoration(
      color: userColor(admin.id),
      borderRadius: borderRadius != null
          ? BorderRadius.circular(borderRadius)
          : .circular((width ?? 30) / 2),
    ),
    child: Center(
      child: Text(
        admin.name[0].toUpperCase(),
        style: TextStyle(
          color: userColor(admin.id).appropriateTextColor,
          fontSize: (((width ?? 30) + (height ?? 30)) / 2) * 0.66,
          fontWeight: .bold,
        ),
      ),
    ),
  );
}
