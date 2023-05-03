import 'package:admin/main.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/not_found_screen.dart';
import 'package:admin/screens/profile/login.dart';
import 'package:admin/utils/stock_isolate.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AppRoutes {
  void setup() {
    QR.settings.notFoundPage = QRoute(
        path: '/404',
        builder: () => const VE(d: VS(iso: NotFoundScreenDetails())));
    QR.settings.pagesType = const QFadePage();
    QR.settings.enableDebugLog = true;
    QR.settings.autoRestoration = true;
  }

  final route = [
    QRoute(path: '/', builder: () => const VE(d: VS(iso: DashboardScreen()))),
    QRoute(
      path: '/logout',
      builder: () => const VE(d: VS(iso: DashboardScreen())),
    ),
    QRoute(
      path: '/asset',
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
          builder: () => VE(d: VS(iso: RegisterDetails())),
          children: [
            QRoute(
              path: '/:name',
              builder: () => VE(
                  d: VS(
                      iso: StockIsolate(
                asset: "stock",
                stock: QR.params['name'].toString(),

                //service: IsarService(),
              ))),
              children: [
                QRoute(
                  path: '/info',
                  builder: () => VE(d: VS(iso: LoginDetails())),
                ),
              ],
            ),
          ],
        ),
        QRoute(
          path: '/products',
          builder: () => VE(d: VS(iso: LoginDetails())),
        ),
      ],
    ),
  ];
}
