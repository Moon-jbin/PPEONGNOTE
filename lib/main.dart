import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/utill/routing/router.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemUiOverlayStyle mySystemTheme = SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: Colors.transparent);
    return ScreenUtilInit(
      designSize: size.width >= 600
          // ? const Size(600.9389348488247, 913.4271809702136)
          ? const Size(673.5238095238095, 793.1428571428571)
          : const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: mySystemTheme,
          child: MaterialApp.router(
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            // localizationsDelegates: context.localizationDelegates,
            // supportedLocales: context.supportedLocales,
            // locale: context.locale,
            title: 'GNET',
          )),
    );
  }
}
