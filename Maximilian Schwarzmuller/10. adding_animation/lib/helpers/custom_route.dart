import 'package:flutter/material.dart';

// MaterialPageRoute is on the fly navigation with push or push replace
// A modal route that replaces the entire screen with a platform-adaptive transition.

//  this is for single item transition route
// here T is a placeholder for the generic type that can be passed in
class CustomRoute<T> extends MaterialPageRoute<T> {
  // CustomRoute constructor
  CustomRoute({
    WidgetBuilder widgetBuilder,
    RouteSettings routeSettings,
  }) : super(
          builder: widgetBuilder,
          settings: routeSettings,
        );
        
  // buildTransitions is method cotaining all abstract class related with MaterialPageRoute
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // for first page i do not want to animate
    if (settings.name == '/') return child;
    return FadeTransition(
      child: child,
      opacity: animation,
    );
  }
}

// creating custom route transition animation
// work for all items like a theme for general
class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  // generic type function with T having multiples abstract class
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    // child is a item of the route
    Widget child,
  ) {
    if (route.settings.name == '/') return child;
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
