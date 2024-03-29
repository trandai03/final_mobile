import 'package:animate_do/animate_do.dart';
import 'package:cat_api/modules/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/breeds.dart';
import '../../modules/common.dart';

class SearchCat extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  Network _listBreedSearch = Network();
  Map<String, String> params = {};
  @override
  Widget buildResults(BuildContext context) {
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Search Cats"),
    );
  }
}
