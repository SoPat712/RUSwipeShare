import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:ruswipeshare/buy.dart';
import 'package:ruswipeshare/main.dart';
import 'package:ruswipeshare/sell.dart';
import 'profile_screen_custom.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() => [
        const BuyScreen(),
        const SellScreen(),
        const ProfileScreenCustom(),
        const MainScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.shopping_cart),
            title: "Buy",
            activeColorPrimary: CustomMaterialColor(240, 240, 240).mdColor,
            inactiveColorPrimary: Colors.black38),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.attach_money),
          title: "Sell",
          activeColorPrimary: CustomMaterialColor(240, 240, 240).mdColor,
          inactiveColorPrimary: Colors.black38,
          routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            initialRoute: "/",
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: "Profile",
          activeColorPrimary: CustomMaterialColor(240, 240, 240).mdColor,
          inactiveColorPrimary: Colors.black38,
          routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            initialRoute: "/",
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          title: "Settings",
          activeColorPrimary: CustomMaterialColor(240, 240, 240).mdColor,
          inactiveColorPrimary: Colors.black38,
          routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            initialRoute: "/",
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor:
          Theme.of(context).primaryColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: const NavBarDecoration(
          // border: Border(
          //   top: BorderSide(width: 2.0, color: Colors.white),
          // ),
          // borderRadius: BorderRadius.circular(10.0),
          // colorBehindNavBar: Colors.white,
          ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style13, // Choose the nav bar style with this property.
    );
  }
}
 class CustomMaterialColor {
  final int r;
  final int g;
  final int b;

  CustomMaterialColor(this.r, this.g, this.b);

  MaterialColor get mdColor {
    Map<int, Color> color = {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };
    return MaterialColor(Color.fromRGBO(r, g, b, 1).value, color);
  }
}
