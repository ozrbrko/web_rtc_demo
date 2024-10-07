import 'package:flutter/material.dart';
import 'dart:math' as math;

extension WidgetExtension on Widget {
  SizedBox heighted(double num) => SizedBox(height: num, child: this);
  SizedBox w(double num) => SizedBox(width: num, child: this);
  SizedBox sized(double width, double height) => SizedBox(width: width, height: height, child: this);
  SizedBox s(double size) => SizedBox(width: size, height: size, child: this);
  Container decoratedBox({Color? color, double? radius, double? padding, bool shadow = false}) => Container(
      padding: EdgeInsets.all(padding ?? 3),
      decoration: BoxDecoration(
          color: color ?? Colors.blueGrey,
          borderRadius: BorderRadius.circular(radius ?? 6),
          boxShadow: shadow ? [const BoxShadow(color: Colors.grey, offset: Offset(2, 2), blurRadius: 2, spreadRadius: 2)] : null),
      child: Center(child: this));

  Expanded expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  Container bordered({Color? color, double? radius, double? padding}) => Container(
      padding: EdgeInsets.all(padding ?? 3),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(radius ?? 6)),
      child: this);
  Container boxed({Color? color}) => Container(color: color ?? Colors.grey, child: this);

  Widget onTap(Function() function, {HitTestBehavior? hitTestBehavior}) {
    return GestureDetector(
      onTap: () => function(),
      behavior: hitTestBehavior,
      child: this,
    );
  }

  Widget onLongPress(Function() function) {
    return GestureDetector(
      child: this,
      onLongPress: () => function(),
    );
  }

  Widget scrollHorizontal({Key? key, ScrollController? controller, ScrollPhysics? physics, EdgeInsetsGeometry? padding}) => SingleChildScrollView(
        key: key,
        scrollDirection: Axis.horizontal,
        child: this,
      );

  Padding pOnly({Key? key, double left = 0.0, double right = 0.0, double top = 0.0, double bottom = 0.0}) => Padding(
        key: key,
        padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: this,
      );

  Padding py(
    double value, {
    Key? key,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.symmetric(vertical: value),
        child: this,
      );
  Padding px(
    double value, {
    Key? key,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.symmetric(horizontal: value),
        child: this,
      );
  Padding pXY(
    double horizontal,
    double vertical, {
    Key? key,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  /// Gives custom padding from all sides by [value].
  Padding p(double value, {Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget centered({Key? key}) => Center(key: key, child: this);

  Widget h(double height) => SizedBox(
        key: key,
        height: height,
        child: this,
      );

  Widget rotate(double degrees, {Key? key, Alignment alignment = Alignment.center, Offset? origin}) => Transform.rotate(
        key: key,
        angle: _degreeToRad(degrees),
        alignment: alignment,
        origin: origin,
        child: this,
      );

  DecoratedBox backgroundColor(Color? color) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
      ),
      child: this,
    );
  }

  double _degreeToRad(double degrees) => degrees / 180.0 * math.pi;
}
