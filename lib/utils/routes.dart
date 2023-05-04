//*       [IMPORT]
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:go_router/go_router.dart';
//*       [LIB]
import 'package:admin/main.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/not_found_screen.dart';
import 'package:admin/utils/stock_isolate.dart';
import 'package:admin/screens/account/login.dart'; //  Purpose:  Building the Login Screen
import 'package:admin/screens/tools/tools.dart';

class GoR {
  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const VE(d: VS(iso: DashboardScreen()));
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) {
              return const VE(d: VS(iso: DashboardScreen()));
            },
          ),
        ],
      ),
    ],
  );
}

class AppRoutes {
  static const String app = 'app';
  static const String home = 'home';
  static const String root = 'root';
  static const String login = 'login';
  static const String logout = 'logout';
  static const String asset = 'asset';
  static const String product = 'product';
  static const String tools = 'tools';

  void setup() {
    QR.settings.pagesType = const QFadePage();
    QR.settings.enableDebugLog = true;
    QR.settings.autoRestoration = false;
  }

  final route = [
    QR.settings.notFoundPage = QRoute(
        path: '/404',
        name: '404 Not Found',
        builder: () => const VE(d: VS(iso: NotFoundScreenDetails()))),
    QRoute(
      name: app,
      path: '/',
      builder: () => const VE(d: VS(iso: DashboardScreen())),
    ),
    QRoute(
        path: '/login',
        name: login,
        builder: () => const VE(d: VS(iso: LoginDetails()))),
    QRoute(
      path: '/logout',
      name: logout,
      builder: () => const VE(d: VS(iso: DashboardScreen())),
    ),
    QRoute(
      path: '/tools',
      name: tools,
      builder: () => const VE(d: VS(iso: ToolsScreen())),
    ),
    QRoute(
      path: '/asset',
      name: asset,
      meta: {
        'title': 'Asset',
      },
      middleware: [
        //AuthMiddleware(),
      ],
      builder: () => const VE(d: VS(iso: DashboardScreen())),
      children: [
        QRoute(
          path: '/stock/:name',
          name: 'Stock',
          builder: () => VE(
              d: VS(
                  iso: StockIsolate(
            asset: 'stock',
            stock: QR.params['name'].toString(),

            //service: IsarService(),
          ))),
        ),
      ],
    ),
  ];
}
