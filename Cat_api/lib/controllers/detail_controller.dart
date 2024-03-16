import '../modules/cat.dart';
import '../modules/network.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  bool _isLoading = true;
  CatBreedsImage? _catDetail;
  String _idCat = '';

  bool get isLoading => _isLoading;
  CatBreedsImage? get catDetail => _catDetail;
  String get idCat => _idCat;

  @override
  void onInit() {
    if (Get.arguments['id'] != null) {
      _idCat = Get.arguments['id']!;
    }
    _getDetailCat();
    super.onInit();
  }

  void _getDetailCat() async {
    _isLoading = true;
    update();

    final network = Network();
    var response = await network.getDetailCat(id: idCat);
    if (response != null) {
      _catDetail = response;
    }

    _isLoading = false;
    update();
  }
}
