import 'package:flutter/material.dart';

class CustomLayoutBuilder extends StatelessWidget {
  const CustomLayoutBuilder({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Image(
          image: AssetImage(
            imagePath,
          ),
          width: constraints.maxWidth,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
