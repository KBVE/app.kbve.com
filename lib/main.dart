//*  [INFO]
//  Library: Main Dart
//  Purpose: Nerves System and Brain off the application.
//*  [IMPORT]
import 'dart:io';
import 'package:admin/utils/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; //  Library: Flutter -> Material Purpose:  Providing the inner core of the UI/UX for the application, as well as, the main aesthetics for the application front end design.
import 'package:flutter/services.dart'; //  Library: Flutter -> Services
import 'package:hive_flutter/hive_flutter.dart';
//*  [IMPORT] -> [Pub.dev]
import 'package:google_fonts/google_fonts.dart'; //  Library: Google -> Fonts Purpose: Providing the font files for the application.
import 'package:provider/provider.dart'; //  Purpose: A wrapper for the widgets that will be handle the state / action management.
import 'package:qlevar_router/qlevar_router.dart'; // Purpose: Replace go_router
//*   [IMPORT]  -> [App]:[LIB]
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/constants.dart'; //  Purpose: Storing constant variables throughout the application.
import 'package:admin/controllers/MenuController.dart'; //  Purpose:  Handling the menu / drawer for the application.
import 'package:admin/screens/main/not_found_screen.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/responsive.dart';

//! [FUNDAMENTAL]   Main (void)(f) runs app.

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.black38),
  );
  Hive.initFlutter();
  runApp(VirtualEngine());
}

class VirtualEngine extends StatelessWidget {
  VirtualEngine({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appRoutes = AppRoutes();
    appRoutes.setup();
    return MaterialApp.router(
      routerDelegate: QRouterDelegate(appRoutes.route),
      routeInformationParser: QRouteInformationParser(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      restorationScopeId: 'app',
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
