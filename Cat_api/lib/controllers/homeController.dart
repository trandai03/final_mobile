import 'package:get/get.dart';

import '../modules/cat.dart';
import '../modules/network.dart';
import '../modules/breeds.dart';
class HomeController extends GetxController {
  List<CatBreeds> _myListBreeds = [];
  bool _isLoading = true;

  List<CatBreeds> get myListBreeds => _myListBreeds;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    _getBreeds();
    super.onInit();
  }

  void _getBreeds() async {
    _isLoading = true;
    update();

    Map<String, String> params = {};

    final network = Network();
    var response = await network.getListBreeds(params: params);
    if (response != null) {
      _myListBreeds = response;
    }

    _isLoading = false;
    update();
  }

  void goToDetail(String idCat) {
    if (idCat.isNotEmpty) {
      Get.toNamed('/detail_cat', arguments: {'id': idCat});
    }
  }
}

