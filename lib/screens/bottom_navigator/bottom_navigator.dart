import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shop_store/colors/colors.dart';
import 'package:shop_store/screens/account_screen/user_profile.dart';
import 'package:shop_store/screens/cart_Screen.dart/cart_screen.dart';
import 'package:shop_store/screens/favorite_screen/favorite_screen.dart';
import 'package:shop_store/screens/home/home_screen.dart';
import 'package:shop_store/screens/order_screen/order_screen.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({final Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  PersistentTabController _controller = PersistentTabController();
  bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
        HomeScreen(),
        CartScreen(),
        FavoriteScreen(),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: OrderScreen(),
        ),
        UserProfile(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            textStyle: header.copyWith(fontSize: 20, letterSpacing: 2),
            icon: Icon(Icons.home),
            inactiveIcon: Icon(Icons.home_outlined),
            title: "Home",
            activeColorPrimary: red,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
          textStyle: header.copyWith(fontSize: 20, letterSpacing: 2),
          icon: Icon(Icons.shopping_cart),
          inactiveIcon: Icon(Icons.shopping_cart_outlined),
          title: "Cart",
          activeColorPrimary: red,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
          ),
        ),
        PersistentBottomNavBarItem(
          textStyle: header.copyWith(fontSize: 20, letterSpacing: 2),
          icon: Icon(Icons.favorite),
          inactiveIcon: Icon(Icons.favorite_border),
          title: "Favorite",
          activeColorPrimary: red,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          textStyle: header.copyWith(fontSize: 20, letterSpacing: 2),
          icon: Icon(Icons.list_alt_outlined),
          inactiveIcon: Icon(Icons.list_sharp),
          title: "Orders",
          activeColorPrimary: red,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          textStyle: header.copyWith(fontSize: 20, letterSpacing: 2),
          icon: Icon(Icons.person),
          inactiveIcon: Icon(Icons.person_2_outlined),
          title: "Profile",
          activeColorPrimary: red,
          inactiveColorPrimary: Colors.grey,
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,

          backgroundColor: darkshade,
          hideNavigationBar: _hideNavBar,
          decoration: NavBarDecoration(
            colorBehindNavBar: Colors.indigo,
          ),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle:
              NavBarStyle.style1, // Choose the nav bar style with this property
        ),
      );
}
