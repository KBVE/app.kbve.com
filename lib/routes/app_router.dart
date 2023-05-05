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
import 'package:admin/utils/screen_isolate.dart';
import 'package:admin/routes/index.dart';
import 'package:admin/routes/app_iso.dart';

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
            child: const VE(d: VS(iso: LoginScreen())),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.logout.name,
        path: AppRoutes.logout.path,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const VE(d: VS(iso: LoginScreen())),
          );
        },
      ),
      createISO('application'),
      createISO('arcade'),
      createISO('blog'),
      createISO('gaming'),
      createISO('journal'),
      createISO('legal'),
      createISO('project'),
      createISO('recipe'),
      createISO('releases'),
      createISO('security'),
      createISO('team'),
      createISO('theory'),
      createISO('tools'),
      GoRoute(
          name: AppRoutes.asset.name,
          path: AppRoutes.asset.path,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const VE(d: VS(iso: LoginScreen())),
            );
          },
          routes: [
            GoRoute(
              name: 'stock',
              path: 'stock',
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: VE(d: VS(iso: LoginScreen())),
                );
              },
            ),
            GoRoute(
              name: 'stock_',
              path: 'stock/:stockId',
              pageBuilder: (context, state) {
                var stockId = '';
                if (state.pathParameters['stockId'] != null)
                  stockId = state.pathParameters['stockId'].toString();

                return MaterialPage(
                  key: state.pageKey,
                  child: VE(
                      d: VS(
                          iso: StockIsolate(
                              asset: 'asset/stock', stock: stockId))),
                );
              },
            )
          ]),
    ],
  );
}

GoRoute createISO(String isoState) {
  return GoRoute(
      name: isoState,
      path: '/$isoState',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: VE(d: VS(iso: LoginScreen())),
        );
      },
      routes: [
        GoRoute(
          name: '$isoState/',
          path: ':pId',
          pageBuilder: (context, state) {
            var pId = '';
            if (state.pathParameters['pId'] != null)
              pId = state.pathParameters['pId'].toString();

            return MaterialPage(
              key: state.pageKey,
              child: VE(d: VS(iso: AIsolate(path: isoState, file: pId))),
            );
          },
        )
      ]);
}
