//*  [INFO]
//  Library: Main Dart
//  Purpose: Nerves System and Brain off the application.
//*  [IMPORT]
import 'package:isar/isar.dart';
import 'package:admin/isar_service.dart';
import 'package:admin/screens/dashboard/components/entry_builder.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart'; //  Library: Flutter -> Material Purpose:  Providing the inner core of the UI/UX for the application, as well as, the main aesthetics for the application front end design.
import 'package:flutter/services.dart'; //  Library: Flutter -> Services
//*  [IMPORT] -> [Pub.dev]
import 'package:google_fonts/google_fonts.dart'; //  Library: Google -> Fonts Purpose: Providing the font files for the application.
import 'package:provider/provider.dart'; //  Purpose: A wrapper for the widgets that will be handle the state / action management.
import 'package:qlevar_router/qlevar_router.dart'; // Purpose: Replace go_router
//*   [IMPORT]  -> [App]:[LIB]
import 'package:admin/constants.dart'; //  Purpose: Storing constant variables throughout the application.
import 'package:admin/controllers/MenuController.dart'; //  Purpose:  Handling the menu / drawer for the application.
import 'package:admin/screens/profile/login.dart'; //  Purpose:  Building the Login Screen
import 'package:admin/screens/main/not_found_screen.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/responsive.dart';
//! [FUNDAMENTAL]   Main (void)(f) runs app.

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.black38),
  );
  runApp(VirtualEngine());
}

class AppRoutes {
  static const String dashboard = 'asset';
  static const String dashboardHome = 'dashboard_home';
  static const String dashboardStores = 'dashboard_stores';
  static const String dashboardStoresId = 'dashboard_stores_id';
  static const String dashboardStoreIdProduct = 'dashboard_store_id_product';
  static const String dashboardProducts = 'dashboard_products';

  final route = [
    QR.settings.notFoundPage = QRoute(
        path: '/404',
        pageType: const QFadePage(),
        builder: () => const VE(d: VS(iso: NotFoundScreenDetails()))),
    QRoute(
        path: '/',
        name: 'Dashboard',
        pageType: const QFadePage(),
        builder: () => const VE(d: VS(iso: DashboardScreen()))),
    QRoute(
      path: '/logout',
      name: dashboardHome,
      builder: () => const VE(d: VS(iso: DashboardScreen())),
    ),
    QRoute(
      path: '/asset',
      name: dashboard,
      pageType: const QFadePage(),
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
          name: dashboardStores,
          builder: () => VE(d: VS(iso: RegisterDetails())),
          children: [
            QRoute(
              path: '/:name',
              name: dashboardStoresId,
              pageType: const QMaterialPage(),
              builder: () => VE(
                  d: VS(
                      iso: EntryBuilder(
                          assetClass: "stock",
                          assetName: QR.params['name'].toString()))),
              children: [
                QRoute(
                  path: '/info',
                  name: dashboardStoreIdProduct,
                  pageType: const QMaterialPage(),
                  builder: () => VE(d: VS(iso: LoginDetails())),
                ),
              ],
            ),
          ],
        ),
        QRoute(
          path: '/products',
          name: dashboardProducts,
          builder: () => VE(d: VS(iso: LoginDetails())),
        ),
      ],
    ),
  ];
}

class VirtualEngine extends StatelessWidget {
  VirtualEngine({Key? key}) : super(key: key);
  final service = IsarService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: QRouterDelegate(AppRoutes().route, initPath: '/'),
      routeInformationParser: QRouteInformationParser(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
    );
  }
}

class VE extends StatelessWidget {
  final Widget d;
  const VE({Key? key, required this.d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
            child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CustomMenuController())
          ],
          child: d,
        )),
      ),
    );
  }
}

class VS extends StatelessWidget {
  final Widget iso;
  const VS({Key? key, required this.iso}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<CustomMenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                primary: false,
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Header(),
                    SizedBox(height: defaultPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: iso,
                          ),
                        ),
                        if (!Responsive.isMobile(context))
                          SizedBox(width: defaultPadding),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//  ![VE]   ->  [END]
