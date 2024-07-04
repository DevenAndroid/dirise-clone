import 'dart:convert';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/profile_controller.dart';
import '../../model/vendor_earnings_model.dart';
import '../../model/vendor_models/model_withdrawal_list.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';

class WithdrawMoney extends StatefulWidget {
  const WithdrawMoney({Key? key}) : super(key: key);
  static var route = "/withdrawMoney";

  @override
  State<WithdrawMoney> createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {
  final TextEditingController addMoneyController = TextEditingController();

  final Repositories repositories = Repositories();

  // ModelWithdrawalList? modelWithdrawalList;
  Rx<VendorEarningsModel> vendorEarningsModel = VendorEarningsModel().obs;
  List<int> suggestionAmount = [];

  // Future getWithdrawalMoney() async {
  //   await repositories.getApi(url: ApiUrls.withdrawalListUrl).then((value) {
  //     modelWithdrawalList = ModelWithdrawalList.fromJson(jsonDecode(value));
  //     num temp = modelWithdrawalList!.data!.earnedBalance.toString().toNum;
  //     if (temp > 0) {
  //       if (suggestionAmount.length < 3 && temp > 200) suggestionAmount.add(200);
  //       if (suggestionAmount.length < 3 && temp > 600) suggestionAmount.add(600);
  //       if (suggestionAmount.length < 3 && temp > 1000) suggestionAmount.add(1000);
  //     }
  //     setState(() {});
  //   });
  // }
  getEarnings() {
    repositories.getApi(url: ApiUrls.vendorEarningNew).then((value) {
      vendorEarningsModel.value = VendorEarningsModel.fromJson(jsonDecode(value));
      setState(() {

      });
    });
  }

  Color yellowColor = const Color(0xffFFB26B);
  Color greenColor = const Color(0xff65CD90);
  Color rejectColor = const Color(0xffFF557E);

  Future withDrawRequest(String amount) async {
    await repositories.postApi(url: ApiUrls.withdrawalRequestUrl,
        context: context,
        mapData: {
          'amount': amount
        }).then((value) {
      ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
      if (modelCommonResponse.status == true) {
        addMoneyController.clear();
      }
      showToast(modelCommonResponse.message.toString());
      // getWithdrawalMoney();
    });
  }

  @override
  void initState() {
    super.initState();
    getEarnings();

     // getWithdrawalMoney();
  }
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Earnings'.tr,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xff423E5E),
            ),
          ),
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment : MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: profileController.selectedLAnguage.value != 'English' ?
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
                ),
              ),
            ],
          ),
        ),
        // appBar: backAppBar(title: "Withdrawal money".tr, context: context),
        body:
        // modelWithdrawalList != null
        vendorEarningsModel.value.status == true
            ? Obx(() {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF37C666).withOpacity(0.10),
                        offset: const Offset(
                          .1,
                          .1,
                        ),
                        blurRadius: 20.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: AddSize.padding16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Earnings".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                                  ),
                                  Text(
                                    "kwd${vendorEarningsModel.value.vendorEarnings.toString()}",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 31,
                                        color: const Color(0xFF262F33)),
                                  ),
                                ],
                              ),
                            ),
                            // Container(
                            //   height: 40,
                            //   width: 40,
                            //   decoration: BoxDecoration(
                            //     color: AppTheme.buttonColor,
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   child: const Icon(
                            //     Icons.account_balance_wallet_sharp,
                            //     color: Colors.white,
                            //   ),
                            // )
                          ],
                        ),
                      )),
                ),
                // child: Form(
                //   // key: _formKey,
                //   child: Column(
                //     children: [
                //
                //       SizedBox(
                //         height: AddSize.size5,
                //       ),
                //       if (modelWithdrawalList!.data!.earnedBalance.toString().toNum > 0) ...[
                //         Container(
                //           decoration: BoxDecoration(
                //             boxShadow: [
                //               BoxShadow(
                //                 color: const Color(0xFF37C666).withOpacity(0.10),
                //                 offset: const Offset(
                //                   .1,
                //                   .1,
                //                 ),
                //                 blurRadius: 20.0,
                //                 spreadRadius: 1.0,
                //               ),
                //             ],
                //           ),
                //           child: Card(
                //               elevation: 0,
                //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //               color: Colors.white,
                //               child: Padding(
                //                   padding:
                //                       EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                //                   child: Column(
                //                     children: [
                //                       TextFormField(
                //                           keyboardType: TextInputType.number,
                //                           inputFormatters: [
                //                             FilteringTextInputFormatter.digitsOnly
                //                           ],
                //                           textAlign: TextAlign.center,
                //                           style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                //                               color: Colors.black,
                //                               fontWeight: FontWeight.w600,
                //                               fontSize: AddSize.font24),
                //                           controller: addMoneyController,
                //                           cursorColor: const Color(0xFF7ED957),
                //                           // validator: validateMoney,
                //                           decoration: const InputDecoration(
                //                             hintText: "+1000kwd",
                //                             suffixIcon: Icon(Icons.attach_money_rounded),
                //                             prefixIcon: Icon(Icons.add,color: Colors.transparent,),
                //                           )),
                //                       SizedBox(
                //                         height: AddSize.size15,
                //                       ),
                //                       Row(
                //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                         children: List.generate(
                //                           suggestionAmount.length,
                //                           (index) => chipList("${suggestionAmount[index]}"),
                //                         ),
                //                       ),
                //                       const SizedBox(
                //                         height: 10,
                //                       ),
                //                       ElevatedButton(
                //                           onPressed: () {
                //                             if(addMoneyController.text.isEmpty){
                //                               showToast("Please enter amount".tr);
                //                               return;
                //                             }
                //                             if(addMoneyController.text.toNum < modelWithdrawalList!.data!.earnedBalance.toString().toNum){
                //                               withDrawRequest(addMoneyController.text);
                //                             } else{
                //                               showToast("Entered amount is greater then balance".tr);
                //                             }
                //                           },
                //                           style: ElevatedButton.styleFrom(
                //                               minimumSize: Size(double.maxFinite, AddSize.size50),
                //                               backgroundColor: AppTheme.buttonColor,
                //                               elevation: 0,
                //                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //                               textStyle: GoogleFonts.poppins(
                //                                   fontSize: AddSize.font20, fontWeight: FontWeight.w500)),
                //                           child: Text(
                //                             "Withdrawal".tr.toUpperCase(),
                //                             style: GoogleFonts.poppins(
                //                                 color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                //                           )),
                //                     ],
                //                   ))),
                //         ),
                //         SizedBox(
                //           height: AddSize.size10,
                //         ),
                //       ],
                //       // Expanded(
                //       //   child: Container(
                //       //     decoration: BoxDecoration(
                //       //         color: Colors.white,
                //       //         boxShadow: [
                //       //           BoxShadow(
                //       //             color: const Color(0xFF37C666).withOpacity(0.10),
                //       //             offset: const Offset(
                //       //               .1,
                //       //               .1,
                //       //             ),
                //       //             blurRadius: 20.0,
                //       //             spreadRadius: 1.0,
                //       //           ),
                //       //         ],
                //       //         // color: AppTheme.backgroundcolor,
                //       //         borderRadius: BorderRadius.circular(20)),
                //       //     child: Padding(
                //       //       padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
                //       //       child: Column(
                //       //         children: [
                //       //           Row(
                //       //             children: [
                //       //               Expanded(
                //       //                 flex: 2,
                //       //                 child: Text(
                //       //                   "Amount".tr,
                //       //                   style: GoogleFonts.poppins(
                //       //                       height: 1.5,
                //       //                       fontWeight: FontWeight.w600,
                //       //                       fontSize: 12,
                //       //                       color: AppTheme.buttonColor),
                //       //                 ),
                //       //               ),
                //       //               Expanded(
                //       //                 flex: 4,
                //       //                 child: Text(
                //       //                   "Date".tr,
                //       //                   textAlign: TextAlign.center,
                //       //                   style: GoogleFonts.poppins(
                //       //                       height: 1.5,
                //       //                       fontWeight: FontWeight.w600,
                //       //                       fontSize: 12,
                //       //                       color: AppTheme.buttonColor),
                //       //                 ),
                //       //               ),
                //       //               Expanded(
                //       //                 flex: 3,
                //       //                 child: Text(
                //       //                   "Status".tr,
                //       //                   textAlign: TextAlign.end,
                //       //                   style: GoogleFonts.poppins(
                //       //                       height: 1.5,
                //       //                       fontWeight: FontWeight.w600,
                //       //                       fontSize: 12,
                //       //                       color: AppTheme.buttonColor),
                //       //                 ),
                //       //               )
                //       //             ],
                //       //           ),
                //       //           const Divider(),
                //       //           Expanded(
                //       //             child: RefreshIndicator(
                //       //               onRefresh: () async {
                //       //                 await getWithdrawalMoney();
                //       //               },
                //       //               child: ListView.builder(
                //       //                 shrinkWrap: true,
                //       //                 itemCount: modelWithdrawalList!.data!.withdrawalList!.length,
                //       //                 itemBuilder: (BuildContext context, int index) {
                //       //                   final item = modelWithdrawalList!.data!.withdrawalList![index];
                //       //                   return Column(
                //       //                     children: [
                //       //                       const SizedBox(
                //       //                         height: 8,
                //       //                       ),
                //       //                       Row(
                //       //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       //                         children: [
                //       //                           Expanded(
                //       //                             flex: 2,
                //       //                             child: Text(
                //       //                               "kwd${item.amount.toString()}",
                //       //                               style: GoogleFonts.poppins(
                //       //                                   height: 1.5, fontWeight: FontWeight.w600, fontSize: 12),
                //       //                             ),
                //       //                           ),
                //       //                           Expanded(
                //       //                             flex: 4,
                //       //                             child: Text(
                //       //                               item.date.toString(),
                //       //                               textAlign: TextAlign.center,
                //       //                               style: GoogleFonts.poppins(
                //       //                                   height: 1.5,
                //       //                                   color: const Color(0xFF8C9BB2),
                //       //                                   fontWeight: FontWeight.w300,
                //       //                                   fontSize: 11),
                //       //                             ),
                //       //                           ),
                //       //                           Expanded(
                //       //                             flex: 3,
                //       //                             child: Text(
                //       //                               item.status.toString(),
                //       //                               textAlign: TextAlign.end,
                //       //                               style: GoogleFonts.poppins(
                //       //                                   height: 1.5,
                //       //                                   fontWeight: FontWeight.w600,
                //       //                                   fontSize: 12,
                //       //                                   color: item.status.toString().toLowerCase() == "approved" ? greenColor : item.status.toString().toLowerCase() == "rejected" ? rejectColor : yellowColor
                //       //                               ),
                //       //                             ),
                //       //                           )
                //       //                         ],
                //       //                       ),
                //       //                       const SizedBox(
                //       //                         height: 8,
                //       //                       ),
                //       //                       index != 4 ? const Divider() : const SizedBox(),
                //       //                       // SizedBox(
                //       //                       //   height: AddSize.size5,
                //       //                       // ),
                //       //                     ],
                //       //                   );
                //       //                 },
                //       //               ),
                //       //             ),
                //       //           ),
                //       //         ],
                //       //       ),
                //       //     ),
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // ),
              ),
            ],
          );
        })
            : const LoadingAnimation());
  }

  chipList(title) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return ChoiceChip(
      padding: EdgeInsets.symmetric(horizontal: width * .005, vertical: height * .005),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), side: BorderSide(color: Colors.grey.shade300)),
      label: Text("+$title kwd",
          style: GoogleFonts.poppins(color: const Color(0xFF262F33), fontSize: 14, fontWeight: FontWeight.w500)),
      selected: false,
      onSelected: (value) {
        setState(() {
          addMoneyController.text = title;
          FocusManager.instance.primaryFocus!.unfocus();
        });
      },
    );
  }
}
