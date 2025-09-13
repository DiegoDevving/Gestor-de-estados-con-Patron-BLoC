import 'package:flutter/material.dart';

class CounterState {
  final int count;
  final int multiplier; // nuevo: 1, 2, 4
  final List<bool> ownedColors;
  final int selectedColorIndex;

  CounterState({
    required this.count,
    required this.multiplier,
    required this.ownedColors,
    required this.selectedColorIndex,
  });

  CounterState copyWith({
    int? count,
    int? multiplier,
    List<bool>? ownedColors,
    int? selectedColorIndex,
  }) {
    return CounterState(
      count: count ?? this.count,
      multiplier: multiplier ?? this.multiplier,
      ownedColors: ownedColors ?? this.ownedColors,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
    );
  }
}

final List<Color> pastelColors = [
  Colors.white,
  Colors.pink.shade100,
  Colors.blue.shade100,
  Colors.green.shade100,
  Colors.purple.shade100,
];
