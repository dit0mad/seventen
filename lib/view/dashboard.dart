import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/navigation_controller.dart';
import 'package:seventen/view/account/account.dart';
import 'package:seventen/view/adminpanel.dart';
import 'package:seventen/view/cart/cart.dart';
import 'package:seventen/view/homescreen/homescreen.dart';
import 'package:seventen/view/products/products.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<NavigationController>(
      builder: (dcontroller) {
        return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            currentIndex: dcontroller.index.value,
            onTap: dcontroller.changeTabIndex,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.sportscourt,
                label: 'News',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.cart,
                label: 'Cart',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person_2,
                label: 'Account',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person,
                label: 'Admin',
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(child: Homescreen());
                });
              case 1:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(child: ProductScreen());
                });
              case 2:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(child: Cart());
                });
              case 3:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(child: Account());
                });

              default:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(child: AdminPanel());
                });
            }
          },
        );
      },
    );
  }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
