import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tobeto_mobile_app/screens/dashboard_screen/widgets/custom_navbar.dart';
import 'package:tobeto_mobile_app/screens/screens.dart';
import 'package:tobeto_mobile_app/utils/constant/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _HomeState();
}

class _HomeState extends State<DashboardScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        controller: _controller,
        tabs: [
          PersistentTabConfig(
              screen: const ProfileScreen(),
              item: ItemConfig(
                icon: Image.asset(ImagePath.profileActive),
                title: TobetoText.bottomIconProfile,
                inactiveIcon: Image.asset(ImagePath.profile),
              )),
          PersistentTabConfig(
              screen: const EducationScreen(),
              item: ItemConfig(
                icon: Image.asset(ImagePath.trainingsActive),
                title: TobetoText.bottomIconEducation,
                inactiveIcon: Image.asset(ImagePath.trainings),
              )),
          PersistentTabConfig(
              screen: const HomeScreen(),
              item: ItemConfig(
                icon: Image.asset(
                  ImagePath.homepageActive,
                  width: IconSize.size35px,
                ),
                inactiveIcon: Image.asset(
                  ImagePath.homepage,
                  width: IconSize.size35px,
                ),
              )),
          PersistentTabConfig(
              screen: const CatalogScreen(),
              item: ItemConfig(
                icon: Image.asset(ImagePath.catalogActive),
                title: TobetoText.bottomIconCatalog,
                inactiveIcon: Image.asset(ImagePath.catalog),
              )),
          PersistentTabConfig(
              screen: const LoginScreen(),
              item: ItemConfig(
                icon: Image.asset(ImagePath.calendarActive),
                title: TobetoText.bottomIconCalendar,
                inactiveIcon: Image.asset(ImagePath.calendar),
              ))
        ],
        navBarBuilder: (navBarConfig) => CustomNavBar(
              navBarConfig: navBarConfig,
            ));
  }
}
