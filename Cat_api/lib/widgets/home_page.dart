import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/homeController.dart';
import '../modules/cat.dart';
import '../modules/common.dart';
import '../modules/network.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Breed> BreedData = <Breed>[];

  @override
  void initState() {
    super.initState();
    Network.getCatImages().then((dataFromSever) {
      setState(() {
        BreedData = dataFromSever;
      });
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return GetBuilder<HomeController>(
  //     init: HomeController(),
  //     builder: (_) {
  //       return Scaffold(
  //         appBar: AppBar(
  //           title: const Text('Cats Breeds'),
  //         ),
  //         body: Padding(
  //           padding: const EdgeInsets.symmetric(
  //             vertical: 20,
  //             horizontal: 20,
  //           ),
  //           child: Skeleton(
  //             skeleton: SkeletonListView(),
  //             isLoading: _.isLoading,
  //             child: ListView.builder(
  //               itemCount: _.myListBreeds.length,
  //               itemBuilder: (context, index) {
  //                 Breed pokemon = _.myListBreeds[index];
  //                 return _buildCards(index + 1, pokemon, _);
  //               },
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cats Breeds'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: ListView.builder(
                itemCount: BreedData.length,
                itemBuilder: (context, index) {
                  Breed pokemon = BreedData[index];
                  return _buildCards(index + 1, pokemon, _);
                },
              ),
            ),
          );
        });
  }

  Widget _buildCards(int index, Breed breed, HomeController _) {
    return InkWell(
      onTap: () {
        _.goToDetail(breed.referenceImageId ?? '');
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
                'Name:  ${breed.name}',
                style: Theme.of(Get.context!).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Image.network(
                  '${Common().baseUrlImageCats}${breed.referenceImageId}.jpg',
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
                          color: Colors.red,
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
                    'Origin: ${breed.origin}',
                    style: Theme.of(Get.context!).textTheme.bodyText1,
                  ),
                  Text(
                    'Intelligence: ${breed.intelligence}',
                    style: Theme.of(Get.context!).textTheme.bodyText1,
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
