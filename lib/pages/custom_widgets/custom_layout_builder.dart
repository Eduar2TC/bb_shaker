import 'package:baby_shaker/pages/custom_widgets/shake_animation.dart';
import 'package:flutter/material.dart';

class CustomLayoutBuilder extends StatefulWidget {
  const CustomLayoutBuilder({
    super.key,
    required this.imagePath,
    required this.animationController,
  });

  final String imagePath;
  final AnimationController animationController;

  @override
  State<CustomLayoutBuilder> createState() => _CustomLayoutBuilderState();
}

class _CustomLayoutBuilderState extends State<CustomLayoutBuilder>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    const String tmpString = 'lib/assets/images/shake.png';
    return LayoutBuilder(
      builder: (context, constraints) {
        return widget.imagePath == tmpString
            ? ShakeAnimation(
                animationController: widget.animationController,
                child: Image(
                  image: AssetImage(
                    widget.imagePath,
                  ),
                  width: constraints.maxWidth,
                  fit: BoxFit.scaleDown,
                ),
              )
            : Image(
                image: AssetImage(
                  widget.imagePath,
                ),
                width: constraints.maxWidth,
                fit: BoxFit.cover,
              );
      },
    );
  }
}
