import 'dart:ui';
import 'package:flutter/material.dart';

class CustomMainTabbarView extends StatelessWidget {
  final int currentIndex;
  final List<IconData> icons;
  final Color imgColor;
  final Color selectedColor;
  final Color circleColor;
  final Function(int) onTap;

  const CustomMainTabbarView({
    super.key,
    this.currentIndex = 0,
    required this.icons,
    this.imgColor = Colors.black,
    this.selectedColor = Colors.white,
    this.circleColor = Colors.black,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    final width = mediaQuery.size.width - 40; // padding 20 + 20
    final itemWidth = width / icons.length;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          alignment: Alignment.center,
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: Offset(0, 0),
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [

              /// BACKGROUND BLUR (BOTTOM)
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.light
                          ? Colors.transparent
                          : Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ),
              ),

              /// MOVING CIRCLE
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                left: currentIndex * itemWidth + (itemWidth / 2 - 28),
                top: 5,
                child: Container(
                  width: 55, height: 55,
                  decoration: BoxDecoration(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              /// TabBar UI
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(icons.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => onTap(index),
                      child: Center(
                        child: Icon(
                          size: 30,
                          icons[index],
                          color: currentIndex == index ? selectedColor : imgColor,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}