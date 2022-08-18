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
        builder: (context, state) => _HomeScreen(),
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        //builder: (context, state) => _LoginScreen(),
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: const _LoginScreen()),
      ),
      GoRoute(
          path: '/asset',
          builder: (context, state) => _AssetScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (_, __) => _AssetScreen(),
            ),
          ])
    ],
  );
}

class _AssetScreen extends StatelessWidget {
  const _AssetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('KBVE Asset'),
          //leading: (),
        ),
        body: Container(
            child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuController())
          ],
          child: AssetScreen(),
        )),
      );
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(MyApp.title),
          //leading: (),
        ),
        body: Container(
            child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuController())
          ],
          child: MainScreen(),
        )),
      );
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("KBVE.com Login"),
          //leading: (BackButton()),
        ),
        body: Container(
            child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuController())
          ],
          child: LoginScreen(),
        )),
      );
}
