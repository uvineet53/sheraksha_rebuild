import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget backgroundMotionOverlay(controller) {
  return ZStack([
    SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        alignment: Alignment.bottomLeft,
        child: SizedBox(
          width: controller.value.size?.width ?? 0,
          height: controller.value.size?.height ?? 0,
          child: CachedVideoPlayer(controller),
        ),
      ),
    ),
    Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(.75),
    ),
  ]);
}
