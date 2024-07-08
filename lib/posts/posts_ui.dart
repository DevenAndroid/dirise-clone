import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/posts/post_ui_player.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/profile_controller.dart';
import '../language/app_strings.dart';
import '../model/create_news_model.dart';
import '../model/get_publish_model.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../utils/helper.dart';
import '../widgets/common_colour.dart';
import '../widgets/dimension_screen.dart';
import 'package:image_cropper/image_cropper.dart';


class PublishPostScreen extends StatefulWidget {
  const PublishPostScreen({super.key});

  static String route = "/PublishPostScreen";

  @override
  State<PublishPostScreen> createState() => _PublishPostScreenState();
}

class _PublishPostScreenState extends State<PublishPostScreen> {
  Rx<GetPublishPostModel> getPublishModel = GetPublishPostModel().obs;

  Future getPublishPostData() async {
    repositories.getApi(url: ApiUrls.getPublishUrl).then((value) {
      getPublishModel.value = GetPublishPostModel.fromJson(jsonDecode(value));
    });
  }

  final Repositories repositories = Repositories();

  File pickedFile = File("");
  final formKey = GlobalKey<FormState>();
  String postId = '';
   final profileController = Get.put(ProfileController());

  createPost() {
    Map<String, String> map = {};
    map['title'] = postController.text.toString();
    map['discription'] = postController.text.toString();
    Map<String, File> gg = {};
    if (pickedFile.path.isNotEmpty) {
      gg["file"] = pickedFile;
    }
    if (profileController.userLoggedIn == true) {
      if (pickedFile.path.isNotEmpty || postController.text.trim().isNotEmpty) {
        repositories
            .multiPartApi(mapData: map, images: gg, url: ApiUrls.createPostUrl, context: context, onProgress: (gg, kk) {})
            .then((value) {
          CreateNewsModel response = CreateNewsModel.fromJson(jsonDecode(value));
          showToast(response.message.toString());
          if (response.status == true) {
            getPublishPostData();
            FocusScope.of(context).unfocus();
            _scrollController.animateTo(
              0.0,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
            postController.clear();
            pickedFile = File('');

            showToast(response.message.toString());
          } else {
            showToast(response.message.toString());
          }
        });
      } else {
        showToast('Nothing To Post');
      }
    } else {
      showToast('LogIN YourSelf First');
    }
  }

  addRemoveLike(postId) {
    Map<String, String> map = {};
    map['post_id'] = postId;

    repositories.postApi(mapData: map, url: ApiUrls.addRemoveLike, context: context).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      // showToast(response.message.toString());
      if (response.status == true) {
        getPublishPostData();
        // showToast(response.message.toString());
      } else {
        showToast(response.message.toString());
      }
    });
  }
  deleteNewsApi(postId) {
    Map<String, String> map = {};
    map['news_id'] = postId;

    repositories.postApi(mapData: map, url: ApiUrls.deleteNewsUrl, context: context).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getPublishPostData();
        showToast(response.message.toString());
      } else {
        showToast(response.message.toString());
      }
    });
  }


  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Select Picture from',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Helpers.addImagePicker(imageSource: ImageSource.camera, imageQuality: 75).then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  // aspectRatioPresets: [
                  //   // CropAspectRatioPreset.square,
                  //   // CropAspectRatioPreset.ratio3x2,
                  //   // CropAspectRatioPreset.original,
                  //   CropAspectRatioPreset.ratio4x3,
                  //   // CropAspectRatioPreset.ratio16x9
                  // ],
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.ratio4x3,
                        lockAspectRatio: true),
                    IOSUiSettings(
                      title: 'Cropper',
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  pickedFile = File(croppedFile.path);
                  setState(() {});
                }

                Get.back();
              });
            },
            child: const Text("Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Helpers.addImagePicker(imageSource: ImageSource.gallery, imageQuality: 75).then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  // aspectRatioPresets: [
                  //   // CropAspectRatioPreset.square,
                  //   // CropAspectRatioPreset.ratio3x2,
                  //   // CropAspectRatioPreset.original,
                  //   CropAspectRatioPreset.ratio4x3,
                  //   // CropAspectRatioPreset.ratio16x9
                  // ],

                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.ratio4x3,
                        lockAspectRatio: true),
                    IOSUiSettings(
                      title: 'Cropper',
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  pickedFile = File(croppedFile.path);
                  setState(() {});
                }

                Get.back();
              });
            },
            child: const Text('Gallery'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    profileController.userLoggedIn;
    getPublishPostData();
  }

  TextEditingController postController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.publishPostScreen.tr,
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.newPrimaryColor,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileController.selectedLAnguage.value != 'English' ?
              Image.asset(
                'assets/images/forward_icon.png',
                height: 19,
                width: 19,
              ) :
              Image.asset(
                'assets/images/back_icon_new.png',
                height: 19,
                width: 19,
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return getPublishPostData();
        },
        child: Obx(() {
          return getPublishModel.value.status == true
              ? SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: Get.height,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10).copyWith(bottom: 0),
                      child: Column(
                        children: [
                      profileController.userLoggedIn == true ? Column(
                        children: [
                          Container(
                                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF5F5F5F).withOpacity(0.4),
                                    offset: const Offset(0.0, 0.2),
                                    blurRadius: 2,
                                  ),
                                ]),
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: postController,
                                        maxLength: 5000,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(5000)
                                      ],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Post Something';
                                        }
                                        return null;
                                      },
                                      onChanged: (value){
                                        if(value.length == 5000){
                                          showToastCenter('Maximum characters allowed only 5000');
                                        }
                                        setState(() {
                                          postController.text = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'What’s Happening?',
                                        border: InputBorder.none,
                                        hintStyle: GoogleFonts.poppins(
                                            color: const Color(0xFF5B5B5B), fontWeight: FontWeight.w500, fontSize: 16),
                                        // counterText: '${postController.text.length} / 5000',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            // Image.asset(
                                            //   'assets/images/link-2.png',
                                            //   width: 28,
                                            // ),
                                            // const SizedBox(
                                            //   width: 10,
                                            // ),
                                            GestureDetector(
                                                onTap: () {
                                                  // NewHelper.showImagePickerSheet(
                                                  //     gotImage: (File gg) {
                                                  //       pickedFile = gg;
                                                  //       setState(() {});
                                                  //     },
                                                  //     context: context);
                                                  showActionSheet(context);
                                                },
                                                child: Image.asset(
                                                  'assets/images/gallery-news.png',
                                                  width: 26,
                                                )),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  NewHelper().addVideoPicker().then((value) {
                                                    if (value == null) return;
                                                    pickedFile = value;
                                                    print('path is.... ${pickedFile.path.toString()}');
                                                    setState(() {});
                                                  });
                                                },
                                                child: Image.asset(
                                                  'assets/images/play-cricle.png',
                                                  width: 28,
                                                )),
                                          ],
                                        ),
                                        GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            createPost();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppTheme.buttonColor,
                                              borderRadius: BorderRadius.circular(40),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                            child: const Text(
                                              'Publish Post ',
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    pickedFile.path == ""
                                        ? const SizedBox()
                                        :   Container(
                                      width: AddSize.screenWidth,
                                      height: 160,
                                      alignment: Alignment.center,
                                      child: Image.file(
                                        pickedFile,
                                        fit: BoxFit.cover,
                                        width: AddSize.screenWidth,
                                        errorBuilder: (_, __, ___) => SizedBox(
                                          width: double.maxFinite,
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child:
                                            // PostVideoPlayerFile(fileUrl: pickedFile.path)
                                            BetterPlayer.file(
                                              pickedFile.path,
                                              betterPlayerConfiguration: const BetterPlayerConfiguration(
                                                autoPlay: false,
                                                aspectRatio: 16 / 9,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ),

                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ) : const SizedBox(),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              controller: _scrollController,
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              itemCount: getPublishModel.value.allNews!.length,
                              itemBuilder: (context, index) {
                                var item = getPublishModel.value.allNews![index];
                                String inputDateString = item.createdAt.toString();
                                DateTime dateTime = DateTime.parse(inputDateString);
                                String  formattedDate =
                                    "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF5F5F5F).withOpacity(0.4),
                                          offset: const Offset(0.0, 0.2),
                                          blurRadius: 2,
                                        ),
                                      ]),
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(100),
                                                      child: CachedNetworkImage(
                                                        imageUrl: item.userDetails!.profileImage.toString(),
                                                        height: 45,
                                                        width: 45,
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context, url, error) =>
                                                            Image.asset('assets/images/post_img.png'),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        item.userDetails!.name == '' ? item.userDetails!.email.toString() : item.userDetails!.name.toString(),
                                                        style: GoogleFonts.poppins(
                                                            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                formattedDate.toString(),
                                                style: GoogleFonts.poppins(
                                                    color: const Color(0xFF5B5B5B), fontWeight: FontWeight.w500, fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          // Text(
                                          //   item.discription ?? '',
                                          //   style: GoogleFonts.poppins(
                                          //     color: const Color(0xFF5B5B5B),
                                          //     fontWeight: FontWeight.w500,
                                          //     fontSize: 13,
                                          //     letterSpacing: 0.24,
                                          //   ),
                                          // ),
                                          item.discription == null ? const SizedBox()
                                          : RichText(
                                            text: TextSpan(
                                              text: '',
                                              style: DefaultTextStyle.of(context).style,
                                              children: [
                                                TextSpan(
                                                  text: item.isOpen
                                                      ? item.discription ?? ''
                                                      : (item.discription!.length > 100
                                                      ? item.discription!.substring(0, 100) + "..."
                                                      : item.discription),
                                                  style: GoogleFonts.poppins(
                                                    color: const Color(0xFF5B5B5B),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                    letterSpacing: 0.24,
                                                  ),
                                                ),
                                                if (item.discription!.length > 100)
                                                  WidgetSpan(
                                                    child: InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          item.isOpen = !item.isOpen;
                                                        });
                                                      },
                                                      child: Text(
                                                        item.isOpen ? "Show less".tr : "Show more".tr,
                                                        style:  GoogleFonts.poppins(color: AppTheme.buttonColor,fontWeight: FontWeight.w600,fontSize: 15),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          item.fileType!.contains('image')
                                              ? GestureDetector(
                                            onTap: () {
                                              showImageViewer(context, Image.network(item.file.toString()).image,
                                                  doubleTapZoomable: true,
                                                  swipeDismissible: false);
                                            },
                                                child: SizedBox(
                                                    width: double.maxFinite,
                                                    height: 170,
                                                    child: CachedNetworkImage(
                                                      imageUrl: item.file.toString(),
                                                      fit: BoxFit.cover,
                                                      width: AddSize.screenWidth,
                                                      errorWidget: (context, url, error) => Image.asset(
                                                        'assets/images/Rectangle 39892.png',
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ),
                                                  ),
                                              )
                                              : item.fileType == 'directory'
                                                  ? const SizedBox()
                                                  : item.fileType == ''
                                                      ? const SizedBox()
                                                      : AspectRatio(
                                                          aspectRatio: 16 / 9,
                                                          child:  PostVideoPlayer(
                                                            fileUrl: item.file.toString() ,
                                                          ),
                                                        ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  item.fileType == 'directory'
                                                      ? Container(
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              profileController.userLoggedIn == true ? addRemoveLike(item.id.toString()) : showToast('Login YourSelf First');
                                                            },
                                                            child: item.isLike == true
                                                                ? const Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            )
                                                                : const Icon(
                                                              Icons.favorite_border,
                                                              color: Color(0xFF014E70),
                                                            )),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          item.likeCount.toString(),
                                                          style: GoogleFonts.poppins(
                                                            color: const Color(0xFF014E70),
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 13,
                                                            letterSpacing: 0.24,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                      : Container(
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40),
                                                      color: Colors.white,
                                                    ),
                                                    padding: const EdgeInsets.only(top: 20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              profileController.userLoggedIn == true ? addRemoveLike(item.id.toString()) : showToast('Login YourSelf First');
                                                            },
                                                            child: item.isLike == true
                                                                ? const Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            )
                                                                : const Icon(
                                                              Icons.favorite_border,
                                                              color: Color(0xFF014E70),
                                                            )),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          item.likeCount.toString() ?? '0',
                                                          style: GoogleFonts.poppins(
                                                            color: const Color(0xFF014E70),
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 13,
                                                            letterSpacing: 0.24,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  item.myAccount == true ?
                                                  GestureDetector(
                                                    onTap: (){
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext context) => AlertDialog(
                                                            title: const Text('Delete Post'),
                                                            content: const Text('Do you want to delete your post'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () => Get.back(),
                                                                child: const Text('Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () async {
                                                                  deleteNewsApi(item.id.toString());
                                                                  Get.back();
                                                                },
                                                                child: const Text('OK'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                    },
                                                    child: const Icon(Icons.delete,color: Colors.red,),
                                                  ) : const SizedBox()
                                                ],
                                              )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
              )
              : const LoadingAnimation();
        }),
      ),
    );
  }

}
