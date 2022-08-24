/*  [INFO]  */
//  Library: Main Dart
//  Purpose: Nerves System and Brain off the application.
/*  [START] */
//
//
/*  [IMPORT]  */
//
//
/*  [IMPORT] -> [EXT] */
//
//
//  Library: Flutter -> Material
//  Purpose: Providing the inner core of the UI/UX for the application, as well as, the main aesthetics for the application front end design.
import 'package:flutter/material.dart';
//
//  Library: Google -> Fonts
//  Purpose: Providing the font files for the application.
import 'package:google_fonts/google_fonts.dart';
//
//  Library: Provider
//  Purpose: A wrapper for the widgets that will be handle the state / action management.
import 'package:provider/provider.dart';
//
//  Library: Go Router
//  Purpose: Plugin that handles the core routing / URL structure for the application.
import 'package:go_router/go_router.dart';
//
//
/*  [IMPORT] -> [APP] */
//  Library: (Self) -> Constants
//  Purpose: Storing constant variables throughout the application.
import 'package:admin/constants.dart';
//
//
//  Library:  (Self) -> Controllers -> Menu Controller
//  Purpose:  Handling the menu / drawer for the application.
import 'package:admin/controllers/MenuController.dart';
//
//  Library:  (Self) -> Screen -> Main Screen
//  Purpose:  Building the main screen for the application.
import 'package:admin/screens/main/main_screen.dart';
//
//  Library:  (Self) -> Screen -> Login Screen
//  Purpose:  Building the Login Screen
//  Eviction: Replace this screen with a profile.
import 'package:admin/screens/profile/login.dart';
//
//
//  Library:  (Self) -> Screen -> Asset Screen
//  Purpose:  Building the Asset Screen for the application.
import 'package:admin/screens/asset/asset.dart';
import 'package:admin/screens/asset/assetdata.dart';

//

///
//! [FUNDAMENTAL]
///

///  Main (void)(f) runs app.
void main() {
  runApp(MyApp());
}
//
//

//
//  MyApp <Class> is an extension of a <Stateless> Widget.
//  This class encompasses the core template / eco-system for the application [as a whole].
//  Each route then renders an unique screen/component(s) for the user.
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  //  Constant -> Default Application Title
  //  Displayed on the initial render/load of the stateless "MyApp" widget.
  static const title = 'app.KBVE.com';

  //  Initial <Main> Build and Router
  //  The Router {ROUTE} takes manually defined paths.
  //  ?[Suggestion: We could look into a semi-auto path/routing?].
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: title,
        // Theme Data -> Dark Theme
        // Variables are defined with the constants.dart.
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
      );

// _router <var> holds the routes/paths for the application.
  final _router = GoRouter(
    routes: [
      //
      //  !{ROUTE} ->  [CORE]  -> [START]
      //
      //  ?HOTFIX: Home has a default path of "/".
      //  <path> -> Returns {VE} -> (Main Screen)
      GoRoute(
        path: '/',
        builder: (_, __) => VE(lovechild: MainScreen()),
      ),
      //  ?FUTURE: Home <path> -> /home/
      /* GoRoute(        path: '/home',  builder: (_, __) => VE(lovechild: HomeScreen()),  ),  */
      //  ?FUTURE: Profile <path> -> /profile/
      //  ?FUTURE: Tool <path> -> /tool/
      //  ?FUTURE: Shop <path> -> /shop/
      //
      // Login<path> ->
      GoRoute(
        name: 'login',
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: VE(lovechild: LoginScreen()),
        ),
      ),
      //
      // Asset<path> -> Returns {VE} -> ()
      GoRoute(
          path: '/asset',
          builder: (_, __) => VE(lovechild: AssetScreen()),
          routes: [
            GoRoute(
                path: ':id',
                builder: (_, __) {
                  //final asset = fetchAsset(__.params['id']!);
                  return VE(
                      lovechild: AssetData(
                    asset: __.params['id'],
                  ));
                }),
          ]),
      //
      //  !{ROUTES} -> [CORE] -> [END]
      //
      //  !{ROUTES}  -> [REDIRECTS]  -> [START]
      //
      //  ?CONCERN: HUMAN ERROR - Extra (s) in the trailing URL
      //  Defining common 404 errors and setting up the right redirects.
      GoRoute(
        path: '/assets',
        redirect: (_) => '/asset',
      ),
      GoRoute(
        path: '/assets/:id',
        redirect: (state) => '/asset/${state.params['id']}',
      ),
      /*
      GoRoute(
        path: '/tools/:id',
        redirect: (state) => '/tool/${state.params['id']}',
      ),
      */
      //  !{ROUTES}  -> [REDIRECTS]  -> [END]
    ],
  );
}

//
/* VE Class */
//
//  ![VE]   ->  [START]
//  {VE} <Class> extends a <Stateful> Widget.
//  The extending widget must contain another widget, known as, lovechild.

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
//
//  ![VE]   ->  [END]
