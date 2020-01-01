import 'package:flutter/material.dart';

// <T> 泛型
class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
    WidgetBuilder builder,
    RouteSettings settings,
  }) : super(
          builder: builder,
          settings: settings,
        );

  // 构建一个过渡方法
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // 如果是初始路劲,直接返回child
    if (settings.isInitialRoute) {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  // 构建一个过渡方法
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // 如果是初始路劲,直接返回child
    if (route.settings.isInitialRoute) {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
