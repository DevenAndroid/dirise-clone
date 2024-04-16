import 'dart:convert';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../language/app_strings.dart';
import '../../model/model_virtual_assets.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../utils/styles.dart';
import 'singlecategory_screen.dart';

class AudioFilesListScreen extends StatefulWidget {
  const AudioFilesListScreen({super.key});

  @override
  State<AudioFilesListScreen> createState() => _AudioFilesListScreenState();
}

class _AudioFilesListScreenState extends State<AudioFilesListScreen> {
  final Repositories repositories = Repositories();
  ModelVirtualAssets modelVirtualAssets = ModelVirtualAssets();

  getData() {
    repositories.getApi(url: ApiUrls.virtualAssetsVoiceUrl).then((value) {
      modelVirtualAssets = ModelVirtualAssets.fromJson(jsonDecode(value));
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return modelVirtualAssets.product != null
        ? modelVirtualAssets.product!.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: .74),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                itemCount: modelVirtualAssets.product!.length,
                itemBuilder: (context, index) {
                  final item = modelVirtualAssets.product![index];
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => SingleCategoryScreen(
                          product: item,
                        ));
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Hero(
                              tag: item.featuredImage.toString(),
                              child: Material(
                                color: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                child: Image.network(
                                  item.featuredImage.toString(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            item.pName.toString(),
                            maxLines: 3,
                            style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  );
                })
            : Center(
                child: Text(
                  AppStrings.notHaveAnyVoice.tr,
                  style: normalStyle,
                ),
              )
        : const LoadingAnimation();
  }
}
