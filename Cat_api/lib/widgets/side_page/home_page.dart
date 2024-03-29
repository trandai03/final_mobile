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

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CatBreeds> BreedData = <CatBreeds>[];
  @override
  final user = FirebaseAuth.instance.currentUser!;
  Future addCatFavorite(String id, String email) async {
    await FirebaseFirestore.instance.collection('cat_favorite').add({
      'id': id,
      'email': email,
    });
  }

  Future<void> removeCatFavorite(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cat_favorite')
          .where('email', isEqualTo: email)
          .get();

      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } catch (e) {
      print('Error removing cat favorite: $e');
    }
  }

  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cats Breeds'),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchCat());
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Skeleton(
              skeleton: SkeletonListView(),
              isLoading: _.isLoading,
              child: ListView.builder(
                itemCount: _.myListBreeds.length,
                itemBuilder: (context, index) {
                  CatBreeds pokemon = _.myListBreeds[index];
                  return _buildCards(index + 1, pokemon, _);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCards(int index, CatBreeds catbreeds, HomeController _) {
    return InkWell(
      onTap: () {
        _.goToDetail(catbreeds.referenceImageId ?? '');
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
                    'Name:  ${catbreeds.name}',
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        addCatFavorite(
                            catbreeds.referenceImageId ?? '', user.email!);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Image.network(
                  '${Common().baseUrlImageCats}${catbreeds.referenceImageId}.jpg',
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
                    'Origin: ${catbreeds.origin}',
                  ),
                  Text(
                    'Intelligent: ${catbreeds.intelligence}',
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
