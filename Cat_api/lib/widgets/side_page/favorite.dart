import 'package:animate_do/animate_do.dart';
import 'package:cat_api/widgets/side_page/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import '../../controllers/homeController.dart';
import '../../modules/breeds.dart';
import '../../modules/common.dart';
import '../../modules/network.dart';

class Favorite_page extends StatefulWidget {
  const Favorite_page({super.key});
  @override
  State<Favorite_page> createState() => _Favorite_State();
}

class _Favorite_State extends State<Favorite_page> {
  List<CatBreeds> BreedData = <CatBreeds>[];
  @override
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> removeCatFavorite(String id) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cat_favorite')
          .where('id', isEqualTo: id)
          .get();

      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } catch (e) {
      print('Error removing cat favorite: $e');
    }
  }

  Network _listBreedSearch = Network();
  Map<String, String> params = {};
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<CatBreeds>>(
          future:
              _listBreedSearch.getListBreedSearch(query: query, params: params),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  CatBreeds? cat = data?[index];
                  return _buildCards(index + 1, cat);
                });
          }),
    );
  }

  Widget _buildCards(int index, CatBreeds? catbreeds) {
    return InkWell(
      onTap: () {
        print(catbreeds);
        print(catbreeds?.name);
        print(catbreeds?.referenceImageId);
        Get.toNamed('/detail_cat',
            arguments: {'id': catbreeds?.referenceImageId ?? ''});
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name:  ${catbreeds?.name}',
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Image.network(
                  '${Common().baseUrlImageCats}${catbreeds?.referenceImageId}.jpg',
                  height: 180,
                  fit: BoxFit.scaleDown,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Swing(
                      infinite: true,
                      child: Center(
                        heightFactor: 2,
                        child: Image.network(
                          Common().baseUrlLoadingCats,
                          width: 70,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Origin: ${catbreeds?.origin}',
                  ),
                  Text(
                    'Intelligent: ${catbreeds?.intelligence}',
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
