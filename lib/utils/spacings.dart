import 'package:flutter/material.dart';

SizedBox addSpacing(double size, {bool isVertical = true}) => SizedBox(
      height: isVertical ? size : 0,
      width: isVertical ? 0 : size,
    );
