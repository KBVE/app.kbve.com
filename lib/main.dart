import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/profile/login.dart';

// Asset
import 'package:admin/screens/asset/asset.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Go Router
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static const title = 'KBVE.com';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: title,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
      );

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Container(
            child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuController())
          ],
          child: MainScreen(),
        )),
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        //builder: (context, state) => _LoginScreen(),
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: Container(
              child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => MenuController())
            ],
            child: LoginScreen(),
          )),
        ),
      ),
      GoRoute(
          path: '/asset',
          builder: (context, state) => Container(
                  child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (context) => MenuController())
                ],
                child: AssetScreen(),
              )),
          routes: [
            GoRoute(
              path: ':id',
              builder: (_, __) => Container(
                  child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (context) => MenuController())
                ],
                child: AssetScreen(),
              )),
            ),
          ])
    ],
  );
}
