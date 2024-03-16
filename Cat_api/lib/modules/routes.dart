import '../widgets/home_page.dart';
import '../widgets/detail_page.dart';

import 'package:get/get.dart';
import 'package:get/route_manager.dart' as route;

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
];
