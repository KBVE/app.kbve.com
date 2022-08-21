// Constants
import 'dart:collection';

import 'package:admin/constants.dart';

// Menu Controller
import 'package:admin/controllers/MenuController.dart';

// Main Screen
import 'package:admin/screens/main/main_screen.dart';

// Login Screen
import 'package:admin/screens/profile/login.dart';

// Asset Screen
import 'package:admin/screens/asset/asset.dart';

// UI/UX
import 'package:flutter/material.dart';
// Google Fonts
import 'package:google_fonts/google_fonts.dart';

// Provider
import 'package:provider/provider.dart';

// Go Router
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // App Title
  static const title = 'app.KBVE.com';

  // Initial Main Build and Router
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
// Router
  final _router = GoRouter(
    routes: [
      // Home
      GoRoute(
        path: '/',
        builder: (_, __) => VE(lovechild: MainScreen()),
      ),
      // Login
      GoRoute(
        name: 'login',
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: VE(lovechild: LoginScreen()),
        ),
      ),
      // Asset
      GoRoute(
          path: '/asset',
          builder: (_, __) => VE(lovechild: AssetScreen()),
          routes: [
            GoRoute(
                path: ':id',
                builder: (_, __) {
                  final asset = fetchAsset(__.params['id']!);
                  return VE(lovechild: AssetRender());
                }),
          ])
    ],
  );
}

// VE
class VE extends StatefulWidget {
  final Widget lovechild;
  const VE({Key? key, required this.lovechild}) : super(key: key);
  @override
  State<VE> createState() => _VE();
}

// _VE State
class _VE extends State<VE> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MenuController())
        ],
        child: widget.lovechild,
      )),
    );
  }
}
