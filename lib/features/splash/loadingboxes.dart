import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';

class LoadingBoxes extends StatefulWidget {
  const LoadingBoxes({super.key});

  @override
  State<LoadingBoxes> createState() => _LoadingBoxesState();
}

class _LoadingBoxesState extends State<LoadingBoxes>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnim;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();

    // Setup controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Bounce animation goes from 1.0 to 1.2 and back
    _bounceAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Repeat the animation and cycle active box
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _activeIndex = (_activeIndex + 1) % 5;
        });
        _controller.forward(from: 0);
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final isActive = index == _activeIndex;

        Widget box = AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: isActive ? 18 : 12,
          height: isActive ? 18 : 12,
          decoration: BoxDecoration(
            color: isActive ? colors4Liontent.primaryLight : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );

        // Wrap only the active box with the bounce animation
        return isActive
            ? ScaleTransition(scale: _bounceAnim, child: box)
            : box;
      }),
    );
  }
}

class fallBackforSplash extends StatelessWidget {
  const fallBackforSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors4Liontent.primary,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'It seems like you have a bad network connection'
                ' or the server is down.'
                'Please check back in a few minutes'
                ,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}