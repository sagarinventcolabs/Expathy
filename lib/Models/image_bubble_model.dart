import 'package:flutter/material.dart';

class Mod {
  final double? top;
  final double? left;
  final double? beginXOffSet;
  final double? beginYOffSet;
  final double? endXOffSet;
  final double? endYOffSet;
  final double? imageHeight;
  final double? imageWidth;
  final String? image;
  final Alignment? alignment;

  Mod({
    this.top,
    this.left,
    this.image,
    this.beginXOffSet,
    this.beginYOffSet,
    this.endXOffSet,
    this.endYOffSet,
    this.alignment,
    this.imageHeight,
    this.imageWidth,
  });
}
