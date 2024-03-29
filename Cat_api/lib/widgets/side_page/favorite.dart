import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/network.dart';
import '../../modules/breeds.dart';
import '../../modules/common.dart';
import '../../modules/network.dart';
import '../../modules/cat.dart';

class Favorite_page extends StatefulWidget {
  const Favorite_page({super.key});
  @override
  State<Favorite_page> createState() => _Favorite_State();
}

class _Favorite_State extends State<Favorite_page> {
  List<CatBreeds> BreedData = <CatBreeds>[];
  @override
  final user = FirebaseAuth.instance.currentUser!;
  List<String> id_list = [];

  @override
  void initState() {
    super.initState();
    _fetchID();
  }

  _fetchID() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('cat_favorite').get();
    final snap = snapshot.docs;
    setState(() {
      id_list = snap.map((doc) => doc['id'] as String).toList();
    });
    print(id_list);
  }

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

  Network _getListBreedFavorite = Network();
  Map<String, String> params = {};
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<CatBreedsImage>>(
          future: _getListBreedFavorite.getListBreedFavorite(
              id: id_list, params: params),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print(data?.length);
            print("10");
            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  CatBreedsImage? cat = data?[index];
                  return _buildCards(index + 1, cat);
                });
          }),
    );
  }

  Widget _buildCards(int index, CatBreedsImage? catbreeds) {
    print("1");
    return InkWell(
      onTap: () {
        Get.toNamed('/detail_cat',
            arguments: {'id': catbreeds?.breeds.first.referenceImageId ?? ''});
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Name:  ${catbreeds?.breeds.first.name}',
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          removeCatFavorite(
                              catbreeds?.breeds.first.referenceImageId ?? '');
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Image.network(
                  '${Common().baseUrlImageCats}${catbreeds?.breeds.first.referenceImageId}.jpg',
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
                    'Origin: ${catbreeds?.breeds.first.origin}',
                  ),
                  Text(
                    'Intelligent: ${catbreeds?.breeds.first.intelligence}',
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
