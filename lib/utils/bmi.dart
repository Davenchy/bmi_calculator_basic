import 'dart:math';

import 'package:flutter/material.dart';

double calculateBMI(double weight, double height) => weight / pow(height, 2);

String getBMIDescription(double bmi) {
  if (bmi < 18.5) {
    return 'Underweight';
  } else if (bmi < 25) {
    return 'Healthy Weight';
  } else if (bmi < 30) {
    return 'Overweight';
  } else if (bmi < 35) {
    return 'Obese';
  } else {
    return 'Extremely Obese';
  }
}

double normalizeRange(double min, double max, double value) =>
    (value - min) / (max - min);

Color getBMIColor(double bmi) {
  if (bmi <= 18.5) {
    return Colors.blue;
  } else if (bmi <= 21.75) {
    return Color.lerp(
      Colors.blue,
      Colors.green,
      normalizeRange(18.5, 21.75, bmi),
    )!;
  } else if (bmi <= 27.5) {
    return Color.lerp(
      Colors.green,
      Colors.yellow,
      normalizeRange(21.75, 27.5, bmi),
    )!;
  } else if (bmi <= 32.5) {
    return Color.lerp(
      Colors.yellow,
      Colors.orange,
      normalizeRange(27.5, 32.5, bmi),
    )!;
  } else {
    return Colors.red;
  }
}
