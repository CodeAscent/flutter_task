import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget item;
  final Color? color;
  const CustomButton({
    super.key,
    required this.item,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: Center(child: item),
    );
  }
}
