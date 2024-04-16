// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../app_bar/common_app_bar.dart';
// import '../check_out/add_bag_screen.dart';
//
// class SelectedTeacher extends StatefulWidget {
//   const SelectedTeacher({super.key});
//
//   static var selectedTeacher = "/selectedTeacher";
//
//   @override
//   State<SelectedTeacher> createState() => _SelectedTeacherState();
// }
//
// class _SelectedTeacherState extends State<SelectedTeacher> {
//   List data = ["General Bookstore", "Commercial Bookstore", "Speciality Bookstore", "Dasman Complex"];
//   RxBool status = false.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: CommonAppBar(
//           titleText: 'Teacher',
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 14.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     child: Image(image: AssetImage('assets/images/storybooks.png'))),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Image(
//                       image: AssetImage('assets/images/teacher1.png'),
//                       height: 85,
//                     ),
//                     const SizedBox(
//                       width: 15,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             ("Sara Luies"),
//                             style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 5, bottom: 5),
//                             child: Text(
//                               ("Books, Stationary and Electronics"),
//                               style: GoogleFonts.poppins(
//                                   color: Colors.grey.withOpacity(.7), fontSize: 12, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                           Text(
//                             ("1457 items"),
//                             style: GoogleFonts.poppins(
//                                 color: const Color(0xff014E70), fontSize: 18, fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Text(
//                   ("Brief"),
//                   style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   ("to the rich father and the poor father; What the rich teach and the poor and middle class do not teach their children about to the Publisher's Synopsis"),
//                   style: GoogleFonts.poppins(
//                       color: const Color(0xff014E70), fontSize: 14, fontWeight: FontWeight.w500, height: 1.6),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Text(
//                             ("@"),
//                             style: GoogleFonts.poppins(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             width: 3,
//                           ),
//                           Text(
//                             ("tarachandk786@gmail.com"),
//                             style: GoogleFonts.poppins(
//                                 color: const Color(0xff7D7D7D), fontSize: 14, fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.phone,
//                           size: 20,
//                         ),
//                         const SizedBox(
//                           width: 3,
//                         ),
//                         Text(
//                           ("7689042546"),
//                           style: GoogleFonts.poppins(
//                               color: const Color(0xff7D7D7D), fontSize: 14, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Divider(
//                   thickness: .5,
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 SizedBox(
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: 5,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 20,
//                         childAspectRatio:
//                             MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.3)),
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: () {
//                           bottemSheet();
//                         },
//                         child: Stack(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               margin: const EdgeInsets.only(left: 5),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Image.asset(
//                                     height: size.height * .2,
//                                     'assets/images/bag.png',
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     '50% off',
//                                     style:
//                                         GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     'Ecstasy 165 days ',
//                                     style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     '1 piece',
//                                     style: GoogleFonts.poppins(color: const Color(0xff858484)),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     'USD 12.700',
//                                     style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             const Positioned(top: 7, right: 10, child: Icon(Icons.favorite_border))
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
//
//   Future bottemSheet() {
//     Size size = MediaQuery.of(context).size;
//     return showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         backgroundColor: Colors.white,
//         builder: (context) {
//           return SizedBox(
//             width: size.width,
//             height: size.height * .77,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 25.0),
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Image.asset(
//                           height: size.height * .2,
//                           width: size.width * .7,
//                           'assets/images/bag.png',
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Text(
//                         '50% off',
//                         style: GoogleFonts.poppins(
//                             fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 2,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Text(
//                         'Ecstasy 165 days ',
//                         style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 2,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Text(
//                         '1 piece',
//                         style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 2,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15, right: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 'USD 6.350',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 'USD 12.700',
//                                 style: GoogleFonts.poppins(
//                                     decoration: TextDecoration.lineThrough,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     color: const Color(0xff858484)),
//                               ),
//                             ],
//                           ),
//                           Text(
//                             'Add to list',
//                             style: GoogleFonts.poppins(
//                               shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
//                               color: Colors.transparent,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               decoration: TextDecoration.underline,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         'Description',
//                         style: GoogleFonts.poppins(
//                           shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
//                           color: Colors.transparent,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Text(
//                         'to the rich father and the poor father; What the rich teach and the poor and middle class do not teach their children about to the Publisher s Synopsis: This book will shatter the myth that you need a big income to get rich... -Challenging',
//                         style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, height: 1.7),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//                 Card(
//                   elevation: 10,
//                   child: Container(
//                     color: Colors.white,
//                     width: size.width,
//                     height: 60,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8.0, right: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 18,
//                                 backgroundColor: const Color(0xffEAEAEA),
//                                 child: Center(
//                                     child: Text(
//                                   "━",
//                                   style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
//                                 )),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 "1",
//                                 style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               CircleAvatar(
//                                 radius: 18,
//                                 backgroundColor: const Color(0xffEAEAEA),
//                                 child: Center(
//                                     child: Text(
//                                   "+",
//                                   style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
//                                 )),
//                               ),
//                             ],
//                           ),
//                           InkWell(
//                             onTap: () {
//                               Get.offNamed(BagsScreen.addBagScreen);
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: const Color(0xff014E70), borderRadius: BorderRadius.circular(22)),
//                               padding: const EdgeInsets.fromLTRB(20, 9, 20, 9),
//                               child: Text(
//                                 "Add to Bag",
//                                 style:
//                                     GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
