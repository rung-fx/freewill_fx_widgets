import 'package:flutter/material.dart';

class FXPageIndicator extends StatelessWidget {
  final int pageSize;
  final int currentPage;
  final Color activeColor;
  final double activeSize;
  final Color inactiveColor;
  final double inactiveSize;

  const FXPageIndicator({
    Key? key,
    required this.pageSize,
    required this.currentPage,
    this.activeColor = Colors.blue,
    this.activeSize = 10.0,
    this.inactiveColor = Colors.white54,
    this.inactiveSize = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageSize,
        (index) => Padding(
          padding: const EdgeInsets.only(
            left: 2.0,
            right: 2.0,
          ),
          child: Icon(
            Icons.circle,
            size: index == currentPage ? activeSize : inactiveSize,
            color: index == currentPage ? activeColor : inactiveColor,
          ),
        ),
      ),
    );
  }
}
