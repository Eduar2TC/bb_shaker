import 'package:baby_shaker/pages/custom_widgets/shake_animation.dart';
import 'package:flutter/material.dart';

class CustomLayoutBuilder extends StatelessWidget {
  const CustomLayoutBuilder({
    super.key,
    required this.imagePath,
    required this.animationController,
  });
  final String imagePath;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    const String tmpString = 'lib/assets/images/shake.png';
    return LayoutBuilder(
      builder: (context, constraints) {
        return imagePath == tmpString
            ? ShakeAnimation(
                animationController: animationController,
                child: Image(
                  image: AssetImage(
                    imagePath,
                  ),
                  width: constraints.maxWidth,
                  fit: BoxFit.scaleDown,
                ),
              )
            : Image(
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
