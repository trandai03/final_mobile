import 'package:get/get.dart';

import '../modules/breeds.dart';
import '../modules/network.dart';

class HomeController extends GetxController {
  List<CatBreeds> _myListBreeds = [];
  List<CatBreeds> _myListBreedsSearch = [];
  bool _isLoading = true;

  List<CatBreeds> get myListBreeds => _myListBreeds;
  List<CatBreeds> get myListBreedsSearch => _myListBreedsSearch;

  bool get isLoading => _isLoading;
  String querySearch = "";
  @override
  void onInit() {
    _getBreeds();
    _getBreedsSearch(querySearch);
    super.onInit();
  }

  void _getBreeds() async {
    _isLoading = true;
    update();

    Map<String, String> params = {};

    final network = Network();
    var response;

    response = await network.getListBreeds(params: params);

    if (response != null) {
      _myListBreeds = response;
    }

    _isLoading = false;
    update();
  }

  void _getBreedsSearch(String query) async {
    _isLoading = true;
    update();
    Map<String, String> params = {};

    final network = Network();
    var response =
        await network.getListBreeds(params: params, query: querySearch);
    if (response != null) {
      _myListBreedsSearch = response;
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
