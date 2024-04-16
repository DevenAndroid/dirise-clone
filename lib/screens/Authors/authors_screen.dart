// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:card_swiper/card_swiper.dart';
// import 'package:dirise/screens/Authors/single_author_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../controller/home_controller.dart';
// import '../../controller/single_product_controller.dart';
// import '../../widgets/common_app_bar.dart';
//
// class AuthorsScreen extends StatefulWidget {
//   const AuthorsScreen({super.key});
//
//   static var authorsScreen = "/authorsScreen";
//
//   @override
//   State<AuthorsScreen> createState() => _AuthorsScreenState();
// }
//
// class _AuthorsScreenState extends State<AuthorsScreen> {
//   List data = ["Kuwait", "Gulf", "Arab  World", "World Wide"];
//   RxBool status = false.obs;
//   final _singleCategory = Get.put(SingleCategoryController());
//   final homeController = Get.put(TrendingProductsController());
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     homeController.categoryAuthorData();
//   }
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: CommonAppBar(
//           titleText: 'Authors',
//         ),
//       ),
//       body: Obx(() {
//         return homeController.categoryAuthorsModel.value.user != null
//             ? SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (homeController.categoryAuthorsModel.value.user != null)
//                     SizedBox(
//                     height: size.height * 0.22,
//                     child: Swiper(
//                       autoplay: true,
//                       outer: false,
//                       autoplayDelay: 5000,
//                       autoplayDisableOnInteraction: true,
//                       itemBuilder: (BuildContext context, int index) {
//                         return GestureDetector(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: CachedNetworkImage(
//                                 imageUrl: "https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593360_1280.jpg",
//                                 fit: BoxFit.cover,
//                                 placeholder: (context, url) => const SizedBox(),
//                                 errorWidget: (context, url, error) => const SizedBox()),
//                           ),
//                         );
//                       },
//                       itemCount: 1,
//                       pagination: const SwiperPagination(),
//                       control: const SwiperControl(size: 0), // remove arrows
//                     ),
//                   ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         showModalBottomSheet(
//                             isScrollControlled: true,
//                             context: context,
//                             builder: (context) {
//                               return SizedBox(
//                                 height: size.height * .7,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 24, top: 25, bottom: 10),
//                                           child: Text(
//                                             "Language",
//                                             style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
//                                           ),
//                                         ),
//                                         Obx(() {
//                                           return Column(
//                                             children: List.generate(
//                                                 data.length,
//                                                 (index) => Column(
//                                                       mainAxisSize: MainAxisSize.min,
//                                                       children: [
//                                                         Theme(
//                                                           data: ThemeData(
//                                                               unselectedWidgetColor: const Color(0xff014E70)),
//                                                           child: ListTileTheme(
//                                                             horizontalTitleGap: 5,
//                                                             child: CheckboxListTile(
//                                                               controlAffinity: ListTileControlAffinity.leading,
//                                                               dense: true,
//                                                               visualDensity: VisualDensity.compact,
//                                                               activeColor: const Color(0xff014E70),
//                                                               value: status.value,
//                                                               onChanged: (value) {
//                                                                 setState(() {
//                                                                   status.value = value!;
//                                                                 });
//                                                               },
//                                                               title: Text(
//                                                                 data[index],
//                                                                 style: GoogleFonts.poppins(
//                                                                   fontWeight: FontWeight.w500,
//                                                                   color: Colors.black,
//                                                                   fontSize: 16,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     )),
//                                           );
//                                         }),
//                                       ],
//                                     ),
//                                     Align(
//                                       alignment: Alignment.bottomCenter,
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             alignment: Alignment.center,
//                                             height: 47,
//                                             width: MediaQuery.of(context).size.width * .87,
//                                             decoration: const BoxDecoration(color: Color(0xff014E70)),
//                                             child: Text(
//                                               "Apply",
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Container(
//                                             alignment: Alignment.center,
//                                             height: 47,
//                                             margin: const EdgeInsets.only(bottom: 10),
//                                             width: MediaQuery.of(context).size.width * .87,
//                                             decoration:
//                                                 BoxDecoration(border: Border.all(color: const Color(0xff014E70))),
//                                             child: Text(
//                                               "Clear All",
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: const Color(0xff014E70)),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 13),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 35,
//                               padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: const Color(0xff014E70)),
//                                   color: const Color(0xffEBF1F4),
//                                   borderRadius: BorderRadius.circular(22)),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 8, right: 10),
//                                     child: Text(
//                                       "Topic",
//                                       style: GoogleFonts.poppins(
//                                           fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                                     ),
//                                   ),
//                                   const Icon(
//                                     Icons.keyboard_arrow_down_outlined,
//                                     color: Color(0xff014E70),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 8,
//                             ),
//                             Container(
//                               height: 35,
//                               padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: const Color(0xff014E70)),
//                                   color: const Color(0xffEBF1F4),
//                                   borderRadius: BorderRadius.circular(22)),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 8, right: 10),
//                                     child: Text(
//                                       "language",
//                                       style: GoogleFonts.poppins(
//                                           fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                                     ),
//                                   ),
//                                   const Icon(
//                                     Icons.keyboard_arrow_down_outlined,
//                                     color: Color(0xff014E70),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 8,
//                             ),
//                             Container(
//                               height: 35,
//                               padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: const Color(0xff014E70)),
//                                   color: const Color(0xffEBF1F4),
//                                   borderRadius: BorderRadius.circular(22)),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 8, right: 10),
//                                     child: Text(
//                                       "Topic",
//                                       style: GoogleFonts.poppins(
//                                           fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                                     ),
//                                   ),
//                                   const Icon(
//                                     Icons.keyboard_arrow_down_outlined,
//                                     color: Color(0xff014E70),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 25,
//                     ),
//                     SizedBox(
//                       child: GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: homeController.categoryAuthorsModel.value.user!.length,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 10,
//                             mainAxisSpacing: 20,
//                             childAspectRatio:
//                                 MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.6)),
//                         itemBuilder: (BuildContext context, int index) {
//                           return InkWell(
//                             onTap: () {
//                               Get.toNamed(SingleAuthorScreen.singleAuthorScreen);
//                             },
//                             child: Container(
//
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               margin: const EdgeInsets.only(left: 17),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CachedNetworkImage(
//                                     imageUrl:
//                                         homeController.categoryAuthorsModel.value.user![index].storeImage.toString(),
//                                     placeholder: (context, url) => const SizedBox(),
//                                     errorWidget: (context, url, error) => const SizedBox(),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     homeController.categoryAuthorsModel.value.user![index].storeName.toString(),
//                                     style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     homeController.categoryAuthorsModel.value.user![index].storePhone.toString(),
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : const Center(child: CircularProgressIndicator());
//       }),
//     );
//   }
// }
