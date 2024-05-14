import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:ppeongnote/screen/home_screen.dart';
import 'package:ppeongnote/utill/routing/router_name.dart';

CustomTransitionPage customTransitionPage(GoRouterState state, Widget child) {
  // return CustomTransitionPage(
  //     key: state.pageKey,
  //     child: child,
  //     transitionsBuilder: (_, animation, __, child) {
  //       print('state.name ==> ${state.name}');
  //       //이외는 fade 효과
  //       return FadeTransition(
  //         key: state.pageKey,
  //         opacity: CurvedAnimation(curve: Curves.easeIn, parent: animation),
  //         child: child,
  //       );
  //     });
  return CustomTransitionPage(
      child: child,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeInOutCubicEmphasized));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}

// int count = 1;

// final stream = Stream.periodic(
//   const Duration(seconds: 1),
//   (computationCount) => count = computationCount,
// );

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    // GoRoute(
    //   name: TestRoute,
    //   path: TestRoute,
    //   builder: (BuildContext context, GoRouterState state) => TestScreen(
    //     key: state.pageKey,
    //   ),
    // ),
    // GoRoute(
    //   name: IntroRoute,
    //   path: IntroRoute,
    //   builder: (BuildContext context, GoRouterState state) => IntroScreen(
    //     key: state.pageKey,
    //   ),
    // ),
    GoRoute(
      name: HomeRoute,
      path: HomeRoute,
      builder: (BuildContext context, GoRouterState state) => HomeScreen(
        key: state.pageKey,
      ),
      // pageBuilder: (context, state) =>
      //     customTransitionPage(state, HomeScreen()),
    ),
  ],
);
