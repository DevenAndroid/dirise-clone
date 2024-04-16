// import 'package:dirise/widgets/common_colour.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../app_bar/common_app_bar.dart';
// import '../check_out/add_bag_screen.dart';
//
// class SingleAuthorScreen extends StatefulWidget {
//   const SingleAuthorScreen({super.key});
//
//   static var singleAuthorScreen = "/singleAuthorScreen";
//
//   @override
//   State<SingleAuthorScreen> createState() => _SingleAuthorScreenState();
// }
//
// class _SingleAuthorScreenState extends State<SingleAuthorScreen> {
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
//           titleText: 'Authors',
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 3,
//               ),
//               ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: const Image(image: AssetImage('assets/images/storybooks.png'))),
//               const SizedBox(
//                 height: 25,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Image(
//                     image: AssetImage('assets/images/authors.png'),
//                     height: 85,
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           ("Satyam Rathor"),
//                           style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5, bottom: 5),
//                           child: Text(
//                             ("Books, Stationary and Electronics"),
//                             style: GoogleFonts.poppins(
//                                 color: Colors.grey.withOpacity(.7), fontSize: 12, fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                         Text(
//                           ("1457 items"),
//                           style: GoogleFonts.poppins(
//                               color: const Color(0xff014E70), fontSize: 18, fontWeight: FontWeight.w500),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               InkWell(
//                 onTap: () {
//                   /*showModalBottomSheet(
//                       context: context,
//                       builder: (context) {
//                         return  Column(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 27,top: 15),
//                                   child: Text(
//                                     "Library Type",
//                                     style:
//                                     GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10,),
//                                 Obx(() {return
//                                   Column(
//                                     children: List.generate(
//                                         data.length,
//                                             (index) => Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             CheckboxListTile(
//                                               controlAffinity:
//                                               ListTileControlAffinity.leading,
//                                               dense: true,
//                                               visualDensity: VisualDensity.compact,
//                                               activeColor: const Color(0xff014E70),
//                                               value: status.value,
//                                               onChanged: ( value) {
//                                                 setState(() {
//                                                   status.value=value!;
//                                                 });
//                                               },
//                                               title: Text(
//                                                 data[index],
//                                                 style: GoogleFonts.poppins(
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.black,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                     ),
//                                   );}),
//                               ],),
//                             Align(alignment: Alignment.bottomCenter,
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     alignment: Alignment.center,
//                                     height: 47,
//                                     width:MediaQuery.of(context).size.width *.87,
//                                     decoration: const BoxDecoration(
//                                         color: Color(0xff014E70)
//                                     ),
//                                     child: Text(
//                                       "Apply",
//                                       style:
//                                       GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),
//                                     ),),
//                                   const SizedBox(height: 20,),
//                                   Container(
//                                     alignment: Alignment.center,
//                                     height: 47,
//                                     margin: EdgeInsets.only(bottom: 10),
//                                     width:MediaQuery.of(context).size.width *.87,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey)
//                                     ),
//                                     child: Text(
//                                       "Clear All",
//                                       style:
//                                       GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: const Color(0xff014E70)),
//                                     ),),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       });*/
//                 },
//                 child: Container(
//                   height: 36,
//                   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                   decoration: BoxDecoration(
//                       border: Border.all(color: const Color(0xff014E70)),
//                       color: const Color(0xffEBF1F4),
//                       borderRadius: BorderRadius.circular(22)),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8, right: 10),
//                         child: Text(
//                           "General",
//                           style: GoogleFonts.poppins(
//                               fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                         ),
//                       ),
//                       const Icon(
//                         Icons.keyboard_arrow_down_outlined,
//                         color: AppTheme.buttonColor,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: 5,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 20,
//                       childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.3)),
//                   itemBuilder: (BuildContext context, int index) {
//                     return InkWell(
//                       onTap: () {
//                         bottemSheet();
//                       },
//                       child: Stack(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             margin: const EdgeInsets.only(left: 5),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   height: size.height * .2,
//                                   'assets/images/bag.png',
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   '50% off',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   'Ecstasy 165 days ',
//                                   style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   '1 piece',
//                                   style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'USD 6.350',
//                                       style: GoogleFonts.poppins(
//                                           fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       'USD 12.700',
//                                       style: GoogleFonts.poppins(
//                                           decoration: TextDecoration.lineThrough,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500,
//                                           color: const Color(0xff858484)),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Positioned(top: 7, right: 10, child: Icon(Icons.favorite_border))
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
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
