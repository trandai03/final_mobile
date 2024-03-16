import 'package:get/get.dart';

import '../modules/cat.dart';
import '../modules/network.dart';

class HomeController extends GetxController {
  List<Breed> _myListBreeds = [];
  bool _isLoading = true;

  List<Breed> get myListBreeds => _myListBreeds;
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
      _myListBreeds =
          response as List<Breed>; // Assign only if response is not null
      print("123");
    } else {
      // Handle the case where the response is null
      print("Error: Network request failed or returned null.");
      _myListBreeds = []; // Set an empty list to avoid further errors
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
