import 'package:admin/main.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/not_found_screen.dart';
import 'package:admin/utils/stock_isolate.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:go_router/go_router.dart';
import 'package:admin/screens/account/login.dart'; //  Purpose:  Building the Login Screen

class AppRoutes {
  static const String root = 'root';
  static const String login = 'login';
  static const String logout = 'logout';
  static const String asset = 'asset';
  static const String product = 'product';

  void setup() {
    QR.settings.notFoundPage = QRoute(
        path: '/404',
        name: '404 Not Found',
        builder: () => const VE(d: VS(iso: NotFoundScreenDetails())));

    QR.settings.pagesType = const QFadePage();
    QR.settings.enableDebugLog = true;
    QR.settings.autoRestoration = true;
  }

  final route = [
    QRoute(
        name: root,
        path: '/',
        builder: () => const VE(d: VS(iso: DashboardScreen()))),
    QRoute(
        path: '/login',
        name: login,
        builder: () => const VE(d: VS(iso: DashboardScreen()))),
    QRoute(
      path: '/logout',
      name: logout,
      builder: () => const VE(d: VS(iso: DashboardScreen())),
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
          path: '/stock',
          name: 'Stock',
          builder: () => VE(d: VS(iso: RegisterDetails())),
          children: [
            QRoute(
              path: '/:name',
              name: 'Stock var',
              builder: () => VE(
                  d: VS(
                      iso: StockIsolate(
                asset: 'Stock',
                stock: QR.params['name'].toString(),

                //service: IsarService(),
              ))),
              children: [
                QRoute(
                  path: '/info',
                  name: 'info',
                  builder: () => VE(d: VS(iso: LoginDetails())),
                ),
              ],
            ),
          ],
        ),
        QRoute(
          path: '/products',
          name: product,
          builder: () => VE(d: VS(iso: LoginDetails())),
        ),
      ],
    ),
  ];
}
