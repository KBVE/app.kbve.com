import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//*       [LIB]
import 'package:admin/main.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/not_found_screen.dart';
import 'package:admin/utils/stock_isolate.dart';
import 'package:admin/screens/account/login.dart'; //  Purpose:  Building the Login Screen
import 'package:admin/screens/tools/tools.dart';
import 'package:admin/routes/index.dart';

/// Contains all of the app routes configurations
class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.dashboard.path,
    routes: [
      GoRoute(
        name: AppRoutes.dashboard.name,
        path: AppRoutes.dashboard.path,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const VE(d: VS(iso: DashboardScreen())),
        ),
      ),
      GoRoute(
        name: AppRoutes.login.name,
        path: AppRoutes.login.path,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const VE(d: VS(iso: LoginDetails())),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.logout.name,
        path: AppRoutes.logout.path,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const VE(d: VS(iso: LoginDetails())),
          );
        },
      ),
    ],
  );
}
