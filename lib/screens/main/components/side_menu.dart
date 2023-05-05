import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// Go Router

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              context.go('/');
            },
          ),
          DrawerListTile(
            title: "Asset",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              context.go('/asset');
            },
          ),
          DrawerListTile(
            title: "Tools",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              context.go('/tools');
            },
          ),
          DrawerListTile(
            title: "Documents",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              context.go('/documents');
            },
          ),
          DrawerListTile(
            title: "Store",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              context.go('/store');
            },
          ),
          DrawerListTile(
            title: "Login",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              context.go('/login');
            },
          ),
          DrawerListTile(
            title: "Account",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              context.go('/account');
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              context.go('/account/settings');
            },
          ),
          DrawerListTile(
            title: "Charts",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              context.go('/asset/stock/tsla');
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        // ignore: deprecated_member_use
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
