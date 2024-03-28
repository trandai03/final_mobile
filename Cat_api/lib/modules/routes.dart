import 'package:cat_api/widgets/side_page/main_page.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart' as route;

import '../widgets/navigation.dart';
import '../widgets/side_page/detail_page.dart';
import '../widgets/side_page/home_page.dart';

final routes = [
  GetPage(
    name: '/home',
    page: () => const HomePage(),
    transition: route.Transition.fadeIn,
    transitionDuration: const Duration(
      milliseconds: 1000,
    ),
  ),
  GetPage(
    name: '/detail_cat',
    page: () => const DetailPage(),
    transition: route.Transition.fadeIn,
    transitionDuration: const Duration(
      milliseconds: 1000,
    ),
  ),
  GetPage(
    name: '/main_page',
    page: () => const Mainpage(),
    transition: route.Transition.fadeIn,
    transitionDuration: const Duration(
      milliseconds: 1000,
    ),
  ),
  GetPage(
    name: '/nav_main',
    page: () => const NavigationBarApp(),
    transition: route.Transition.fadeIn,
    transitionDuration: const Duration(
      milliseconds: 1000,
    ),
  ),
];
