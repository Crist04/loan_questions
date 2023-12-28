import 'package:flutter/material.dart';

class CustomTabPageSelector extends StatelessWidget {
  final TabController controller;
  final int itemCount;
  final int currentIndex;
  final Color selectedColor;
  final Color unselectedColor;
  final double indicatorSize;

  const CustomTabPageSelector({
    required this.controller,
    required this.itemCount,
    required this.currentIndex,
    required this.selectedColor,
    required this.unselectedColor,
    required this.indicatorSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        itemCount,
        (index) {
          final isSelected = index == currentIndex;
          final isPastIndex = index < currentIndex;

          return Container(
            
            margin: EdgeInsets.only(right: 3.0),
            width: indicatorSize,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
             borderRadius: BorderRadius.all(Radius.circular(4)),
              color: isSelected
                  ? selectedColor
                  : (isPastIndex ? unselectedColor : const Color.fromARGB(255, 207, 206, 206)),
            ),
          );
        },
      ),
    );
  }
}
