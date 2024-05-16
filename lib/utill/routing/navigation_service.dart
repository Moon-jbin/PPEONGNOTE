import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationService {
  static final NavigationService _singleton = NavigationService._internal();

  factory NavigationService() {
    return _singleton;
  }

  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void routerGO(BuildContext context, String routeName,
      {Map<String, dynamic> queryParams = const {}, WidgetRef? ref}) {
    // if (GoRouter.of(context).location.toString() != routeName) {
    //   if (ref != null) {
    //     ref.read(compareRouteProvier.notifier).setRoute(routeName);
    //   }
      context.goNamed(routeName, queryParameters: queryParams);
    // }
  }

  void routerSet(BuildContext context, String routeName) {
    context.pushReplacement(routeName);
  }

  void routerReplace(BuildContext context, String routeName) {
    // if (routeName == WifiConnectionInfoRoute) {
    //   if (GoRouter.of(context).location.toString() != WifiConnectionInfoRoute) {
    //     context.pushNamed(routeName);
    //   }
    // } else {
      context.pushNamed(routeName);
    // }
  }
}
