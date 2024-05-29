import 'dart:convert';
import 'dart:developer';

import 'package:dirise/language/app_strings.dart';
import 'package:dirise/model/add_product_remark.dart';
import 'package:dirise/model/model_remark_list.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../controller/profile_controller.dart';
import '../../model/aboutus_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';

class RemarkScreen extends StatefulWidget {
  const RemarkScreen({Key? key}) : super(key: key);
  static String route = "/AboutUsScreen";

  @override
  State<RemarkScreen> createState() => _RemarkScreenState();
}

class _RemarkScreenState extends State<RemarkScreen> {

  final profileController = Get.put(ProfileController());
  final Repositories repositories = Repositories();
  Rx<ModelProductRemark> modelRemark = ModelProductRemark().obs;
  TextEditingController remarkController = TextEditingController();
  var id = Get.arguments[0];
  getRemarkDetails()  {
    repositories.getApi(url: ApiUrls.productRemark+id).then((value) {
      modelRemark.value = ModelProductRemark.fromJson(jsonDecode(value));
      log('proooooooo${modelRemark.value.toJson()}');

    });
  }
  Rx<ModelAddProductRemark> modelAddRemark = ModelAddProductRemark().obs;
  Future sendRemark() async {
    Map<String, dynamic> map = {};
    map["product_id"] = id;
    map["remark"] = remarkController.text.toString();
    repositories.postApi(url: ApiUrls.productAddRemark, mapData: map,context: context).then((value) {
      modelAddRemark.value = ModelAddProductRemark.fromJson(jsonDecode(value));
      remarkController.text = "";
      getRemarkDetails();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRemarkDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/icons/backicon.png',
                      height: 25,
                      width: 25,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  10.spaceX,
                  Text(
                    AppStrings.remark.tr,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )),
        body: Obx(() {
          return modelRemark.value.status == true
              ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextField(hintText: 'Remark',controller: remarkController,),
                  SizedBox(height: 20,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomOutlineButton(title: 'Add',onPressed: (){
                      sendRemark();
                    },),
                  ),
SizedBox(height: 20,),
                  Text(
                    "Remark List",
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20,),
                  modelRemark.value.data!.isNotEmpty?
                  ListView.builder(
                    itemCount: modelRemark.value.data!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                 Container(
                   width: Get.width,
                   padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     border: Border.all(color: AppTheme.buttonColor)
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       // Icon(Icons.circle,size: 10,color: AppTheme.buttonColor,),

                       Row(
                         children: [
                           Text("Remark :- "),
                           Text(     modelRemark.value.data![index].remark.toString()),
                         ],
                       ),
                       const SizedBox(height: 12,),
                       Row(
                         children: [
                           Text("Date :- "),
                Text(modelRemark.value.data![index].date.toString()),
                Spacer(),
                Text("Posted By :- "),
                Text(modelRemark.value.data![index].postedBy.toString()),
                ],
              ),
              ],
            ),
          ),
          SizedBox(height: 12,)
          ],
          );
        },):Text("No Data Found")
    ],
              ),
            )

          )
              : const LoadingAnimation();
        }));
  }
}
