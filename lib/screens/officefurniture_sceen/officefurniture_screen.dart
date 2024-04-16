// import 'package:dirise/routers/my_routers.dart';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../controller/home_controller.dart';
// import '../../model/category_furniture_model.dart';
// import '../../model/category_furniture_model.dart';
// import '../../model/category_furniture_model.dart';
// import '../../model/category_furniture_model.dart';
// import '../../widgets/common_app_bar.dart';
// import '../../widgets/common_colour.dart';
// import 'singlechair_screen.dart';
//
// class OfficeFurnitureScreen extends StatefulWidget {
//   static String route = "/OfficeFurnitureScreen";
//   const OfficeFurnitureScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OfficeFurnitureScreen> createState() => _OfficeFurnitureScreenState();
// }
//
// class _OfficeFurnitureScreenState extends State<OfficeFurnitureScreen> {
//   var items = [];
//   final homeController = Get.put(TrendingProductsController());
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     homeController.categoryFurnitureData();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: CommonAppBar(
//           titleText: 'Office Furniture',
//         ),
//       ),
//       body: Column(
//         children: [
//       Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Container(
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(21)),
//                 child: Image.asset('assets/images/officebannerimage.png'),
//               ),
//             ),
//             const SizedBox(
//               height: 13,
//             ),
//           Obx(() {
//             return homeController.categoryFurnitureModel.value.user != null
//                 ? Expanded(
//               child: ListView.builder(
//                 itemCount: items.length + 1,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   if (index == 0) {
//                     return Column(
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: Container(
//                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color(0xffF5F5F5)),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 20),
//                                     child: Text(
//                                       homeController.categoryFurnitureModel.value.user![index].storeName.toString(),
//                                       style: GoogleFonts.poppins(
//                                           color: const Color(0xff131313), fontWeight: FontWeight.w600, fontSize: 18),
//                                     ),
//                                   ),
//                                   Image.asset(
//                                     homeController.categoryFurnitureModel.value.user![index].storeImage.toString(),
//                                     height: 85,
//                                   ),
//                                 ],
//                               )),
//                         ),
//                         SizedBox(height: 10,),
//
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: Container(
//                             height: 70,
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color(0xffF5F5F5)),
//                             child: Row(
//                               children: [
//                                 const SizedBox(
//                                   width: 15,
//                                 ),
//                                 Image.asset('assets/images/taskchair.png'),
//                                 const SizedBox(
//                                   width: 35,
//                                 ),
//                                 Text(
//                                   "Task Chairs",
//                                   style: GoogleFonts.poppins(
//                                       color: const Color(0xFF131313), fontSize: 18, fontWeight: FontWeight.w600),
//                                 ),
//                                 const Spacer(),
//                                 const Icon(
//                                   Icons.arrow_forward_ios,
//                                   size: 22,
//                                   color: Colors.grey,
//                                 ),
//                                 const SizedBox(
//                                   width: 20,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10,),
//
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20, right: 20),
//                           child: Container(
//                             height: 70,
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//                             child: Row(
//                               children: [
//                                 const SizedBox(
//                                   width: 15,
//                                 ),
//                                 Image.asset('assets/images/gameingchair.png'),
//                                 const SizedBox(
//                                   width: 45,
//                                 ),
//                                 Text(
//                                   "Gaming Chairs",
//                                   style: GoogleFonts.poppins(
//                                       color: const Color(0xFF131313), fontSize: 18, fontWeight: FontWeight.w600),
//                                 ),
//                                 const Spacer(),
//                                 InkWell(
//                                   onTap: () {
//                                     Get.toNamed(SingleChairScreen.route);
//                                   },
//                                   child: const Icon(
//                                     Icons.arrow_forward_ios,
//                                     size: 22,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 20,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10,),
//
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20, right: 20),
//                           child: Container(
//                             height: 70,
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//                             child: Row(
//                               children: [
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 Image.asset('assets/images/loungechair.png'),
//                                 const SizedBox(
//                                   width: 25,
//                                 ),
//                                 Text(
//                                   "Lounge Chairs",
//                                   style: GoogleFonts.poppins(
//                                       color: const Color(0xFF131313), fontSize: 18, fontWeight: FontWeight.w600),
//                                 ),
//                                 const Spacer(),
//                                 const Icon(
//                                   Icons.arrow_forward_ios,
//                                   size: 22,
//                                   color: Colors.grey,
//                                 ),
//                                 const SizedBox(
//                                   width: 20,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10,),
//
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                           ),
//                           child: Container(
//                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 20),
//                                     child: Text(
//                                       "Desks",
//                                       style: GoogleFonts.poppins(
//                                           color: const Color(0xff131313), fontWeight: FontWeight.w600, fontSize: 18),
//                                     ),
//                                   ),
//                                   Image.asset(
//                                     'assets/images/desks.png',
//                                     height: 85,
//                                   ),
//                                 ],
//                               )),
//                         ),
//                         SizedBox(height: 10,),
//
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20, right: 20),
//                           child: Container(
//                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 20),
//                                     child: Text(
//                                       "Bookcases",
//                                       style: GoogleFonts.poppins(
//                                           color: const Color(0xff131313), fontWeight: FontWeight.w600, fontSize: 18),
//                                     ),
//                                   ),
//                                   Image.asset(
//                                     'assets/images/bookcase.png',
//                                     height: 85,
//                                   ),
//                                 ],
//                               )),
//                         ),
//                         SizedBox(height: 10,),
//
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20, right: 20),
//                           child: Container(
//                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 20),
//                                     child: Text(
//                                       "Computer Work",
//                                       style: GoogleFonts.poppins(
//                                           color: const Color(0xff131313), fontWeight: FontWeight.w600, fontSize: 18),
//                                     ),
//                                   ),
//                                   Image.asset(
//                                     'assets/images/chairs.png',
//                                     height: 85,
//                                   ),
//                                 ],
//                               )),
//                         ),
//                         SizedBox(height: 10,),
//
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20, right: 20),
//                           child: Container(
//                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 20),
//                                     child: Text(
//                                       "Office Accessories",
//                                       style: GoogleFonts.poppins(
//                                           color: const Color(0xff131313), fontWeight: FontWeight.w600, fontSize: 18),
//                                     ),
//                                   ),
//                                   Image.asset(
//                                     'assets/images/officeitems.png',
//                                     height: 85,
//                                   ),
//                                 ],
//                               )),
//                         ),
//                       ],
//                     );
//                   }
//                   return Text('Item ${items[index].title}');
//                 },
//               ),
//             )
//                 : const Center(child: CircularProgressIndicator());
//           }),
//
//         ],
//       ) ,
//       // body: SingleChildScrollView(
//       //   child: Column(
//       //     children: [
//       //       Padding(
//       //         padding: const EdgeInsets.symmetric(horizontal: 15),
//       //         child: Container(
//       //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(21)),
//       //           child: Image.asset('assets/images/officebannerimage.png'),
//       //         ),
//       //       ),
//       //       const SizedBox(
//       //         height: 13,
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.symmetric(horizontal: 15),
//       //         child: Container(
//       //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color(0xffF5F5F5)),
//       //             child: Row(
//       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //               children: [
//       //                 Padding(
//       //                   padding: const EdgeInsets.only(left: 20),
//       //                   child: Text(
//       //                     "Chairs",
//       //                     style: GoogleFonts.poppins(
//       //                         color: const Color(0xff131313), fontWeight: FontWeight.w600, fontSize: 18),
//       //                   ),
//       //                 ),
//       //                 Image.asset(
//       //                   'assets/images/chairs.png',
//       //                   height: 85,
//       //                 ),
//       //               ],
//       //             )),
//       //       ),
//       //       const SizedBox(
//       //         height: 15,
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.symmetric(horizontal: 15),
//       //         child: Container(
//       //           height: 70,
//       //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color(0xffF5F5F5)),
//       //           child: Row(
//       //             children: [
//       //               const SizedBox(
//       //                 width: 15,
//       //               ),
//       //               Image.asset('assets/images/taskchair.png'),
//       //               const SizedBox(
//       //                 width: 35,
//       //               ),
//       //               Text(
//       //                 "Task Chairs",
//       //                 style: GoogleFonts.poppins(
//       //                     color: const Color(0xFF131313), fontSize: 18, fontWeight: FontWeight.w600),
//       //               ),
//       //               const Spacer(),
//       //               const Icon(
//       //                 Icons.arrow_forward_ios,
//       //                 size: 22,
//       //                 color: Colors.grey,
//       //               ),
//       //               const SizedBox(
//       //                 width: 20,
//       //               ),
//       //             ],
//       //           ),
//       //         ),
//       //       ),
//       //       const SizedBox(
//       //         height: 15,
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.only(left: 20, right: 20),
//       //         child: Container(
//       //           height: 70,
//       //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//       //           child: Row(
//       //             children: [
//       //               const SizedBox(
//       //                 width: 15,
//       //               ),
//       //               Image.asset('assets/images/gameingchair.png'),
//       //               const SizedBox(
//       //                 width: 45,
//       //               ),
//       //               Text(
//       //                 "Gaming Chairs",
//       //                 style: GoogleFonts.poppins(
//       //                     color: const Color(0xFF131313), fontSize: 18, fontWeight: FontWeight.w600),
//       //               ),
//       //               const Spacer(),
//       //               InkWell(
//       //                 onTap: () {
//       //                   Get.toNamed(SingleChairScreen.route);
//       //                 },
//       //                 child: const Icon(
//       //                   Icons.arrow_forward_ios,
//       //                   size: 22,
//       //                   color: Colors.grey,
//       //                 ),
//       //               ),
//       //               const SizedBox(
//       //                 width: 20,
//       //               ),
//       //             ],
//       //           ),
//       //         ),
//       //       ),
//       //       const SizedBox(
//       //         height: 15,
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.only(left: 20, right: 20),
//       //         child: Container(
//       //           height: 70,
//       //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//       //           child: Row(
//       //             children: [
//       //               const SizedBox(
//       //                 width: 5,
//       //               ),
//       //               Image.asset('assets/images/loungechair.png'),
//       //               const SizedBox(
//       //                 width: 25,
//       //               ),
//       //               Text(
//       //                 "Lounge Chairs",
//       //                 style: GoogleFonts.poppins(
//       //                     color: const Color(0xFF131313), fontSize: 18, fontWeight: FontWeight.w600),
//       //               ),
//       //               const Spacer(),
//       //               const Icon(
//       //                 Icons.arrow_forward_ios,
//       //                 size: 22,
//       //                 color: Colors.grey,
//       //               ),
//       //               const SizedBox(
//       //                 width: 20,
//       //               ),
//       //             ],
//       //           ),
//       //         ),
//       //       ),
//       //       const SizedBox(
//       //         height: 20,
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.symmetric(
//       //           horizontal: 20,
//       //         ),
//       //         child: Container(
//       //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//       //             child: Row(
//       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //               children: [
//       //                 Padding(
//       //                   padding: const EdgeInsets.only(left: 20),
//       //                   child: Text(
//       //                     "Desks",
//       //                     style: GoogleFonts.poppins(
//       //                         color: const Color(0xff131313), fontWeight: FontWeight.w600, fontSize: 18),
//       //                   ),
//       //                 ),
//       //                 Image.asset(
//       //                   'assets/images/desks.png',
//       //                   height: 85,
//       //                 ),
//       //               ],
//       //             )),
//       //       ),
//       //       const SizedBox(
//       //         height: 15,
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.only(left: 20, right: 20),
//       //         child: Container(
//       //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//       //             child: Row(
//       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //               children: [
//       //                 Padding(
//       //                   padding: const EdgeInsets.only(left: 20),
//       //                   child: Text(
//       //                     "Bookcases",
//       //                     style: GoogleFonts.poppins(
//       //                         color: const Color(0xff131313), fontWeight: FontWeight.w600, fontSize: 18),
//       //                   ),
//       //                 ),
//       //                 Image.asset(
//       //                   'assets/images/bookcase.png',
//       //                   height: 85,
//       //                 ),
//       //               ],
//       //             )),
//       //       ),
//       //       const SizedBox(
//       //         height: 15,
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.only(left: 20, right: 20),
//       //         child: Container(
//       //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//       //             child: Row(
//       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //               children: [
//       //                 Padding(
//       //                   padding: const EdgeInsets.only(left: 20),
//       //                   child: Text(
//       //                     "Computer Work",
//       //                     style: GoogleFonts.poppins(
//       //                         color: const Color(0xff131313), fontWeight: FontWeight.w600, fontSize: 18),
//       //                   ),
//       //                 ),
//       //                 Image.asset(
//       //                   'assets/images/chairs.png',
//       //                   height: 85,
//       //                 ),
//       //               ],
//       //             )),
//       //       ),
//       //       const SizedBox(
//       //         height: 15,
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.only(left: 20, right: 20),
//       //         child: Container(
//       //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), color: const Color(0xffF5F5F5)),
//       //             child: Row(
//       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //               children: [
//       //                 Padding(
//       //                   padding: const EdgeInsets.only(left: 20),
//       //                   child: Text(
//       //                     "Office Accessories",
//       //                     style: GoogleFonts.poppins(
//       //                         color: const Color(0xff131313), fontWeight: FontWeight.w600, fontSize: 18),
//       //                   ),
//       //                 ),
//       //                 Image.asset(
//       //                   'assets/images/officeitems.png',
//       //                   height: 85,
//       //                 ),
//       //               ],
//       //             )),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }
