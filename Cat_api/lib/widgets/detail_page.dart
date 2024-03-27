import 'package:animate_do/animate_do.dart';
import '../modules/common.dart';
import '../controllers/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: DetailController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cats Detail'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Skeleton(
              skeleton: SkeletonListView(),
              isLoading: _.isLoading,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name:  ${_.catDetail?.breeds.first.name ?? ''}',
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: Image.network(
                          '${Common().baseUrlImageCats}${_.catDetail?.breeds.first.referenceImageId ?? _.idCat}.jpg',
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
                            'Origin: ${_.catDetail?.breeds.first.origin ?? ''}',
                          ),
                          Text(
                            'Intelligence: ${_.catDetail?.breeds.first.intelligence ?? ''}',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Life Span: ${_.catDetail?.breeds.first.lifeSpan ?? ''}',
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'temperament: ${_.catDetail?.breeds.first.temperament ?? ''}',
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Description: ${_.catDetail?.breeds.first.description ?? ''}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
