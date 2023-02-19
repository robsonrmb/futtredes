import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, translateX }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  bool? horizontal;

  FadeAnimation(this.delay, this.child, {AssetImage? image,this.horizontal});

  @override
  Widget build(BuildContext context) {
    if(horizontal== null){
      horizontal = false;
    }
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, 0.0.tweenTo(1.0), 250.milliseconds)
      ..add(AniProps.translateX, (horizontal!?40.0:-30.0).tweenTo(0.0), 250.milliseconds,
          Curves.easeOut);
    /*
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);*/

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (250 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: !horizontal!?
            Transform.translate(
            offset: Offset(0,value.get(AniProps.translateX)), child: child):
            Transform.translate(
            offset: Offset(value.get(AniProps.translateX),0), child: child),
      ),
    );
  }
}