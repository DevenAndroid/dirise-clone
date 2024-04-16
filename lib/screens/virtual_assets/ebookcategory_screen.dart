// import 'package:dirise/widgets/common_colour.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../app_bar/common_app_bar.dart';
// import '../my_account_screens/myaccount_scrren.dart';
// import 'singlecategory_screen.dart';
//
// class EBookCategoryScreen extends StatefulWidget {
//   static String route = "/EBookCategoryScreen";
//   const EBookCategoryScreen({Key? key}) : super(key: key);
//
//   @override
//   State<EBookCategoryScreen> createState() => _EBookCategoryScreenState();
// }
//
// class _EBookCategoryScreenState extends State<EBookCategoryScreen> {
//   List data = ["E Book", "Voice", "Both"];
//   List gender = ["E Book", "Voice", "Both"];
//   RxBool? status = false.obs;
//   List<CheckBoxListTileModel> data1 = CheckBoxListTileModel.getList();
//   List<CheckBoxListTileModel> gender1 = CheckBoxListTileModel.getList();
//   SingingCharacter? _character = SingingCharacter.lafayette;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: CommonAppBar(
//           titleText: 'E Book',
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 13.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: const Image(image: AssetImage('assets/images/storybooks.png'))),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         showModalBottomSheet(
//                             isScrollControlled: true,
//                             context: context,
//                             builder: (context) {
//                               return SizedBox(
//                                 height: size.height * .65,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
//                                       child: Text(
//                                         "Type",
//                                         style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
//                                       ),
//                                     ),
//                                     Obx(() {
//                                       return Column(
//                                         children: List.generate(
//                                             data.length,
//                                             (index) => Column(
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   children: [
//                                                     ListTileTheme(
//                                                       horizontalTitleGap: 5,
//                                                       child: CheckboxListTile(
//                                                         controlAffinity: ListTileControlAffinity.leading,
//                                                         dense: true,
//                                                         visualDensity: VisualDensity.compact,
//                                                         activeColor: const Color(0xff014E70),
//                                                         value: data1[index].isCheck!.value,
//                                                         onChanged: (value) {
//                                                           setState(() {
//                                                             data1[index].isCheck!.value = value!;
//                                                           });
//                                                         },
//                                                         title: Text(
//                                                           data1[index].title.toString(),
//                                                           style: GoogleFonts.poppins(
//                                                             fontWeight: FontWeight.w500,
//                                                             color: Colors.black,
//                                                             fontSize: 16,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )),
//                                       );
//                                     }),
//                                     SizedBox(
//                                       height: size.height * .2,
//                                     ),
//                                     Align(
//                                       alignment: Alignment.bottomCenter,
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             alignment: Alignment.center,
//                                             height: 48,
//                                             width: MediaQuery.of(context).size.width * .9,
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
//                                             height: 48,
//                                             width: MediaQuery.of(context).size.width * .9,
//                                             decoration: BoxDecoration(border: Border.all(color: AppTheme.buttonColor)),
//                                             child: Text(
//                                               "Clear All",
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     )
//                                   ],
//                                 ),
//                               );
//                             });
//                       },
//                       child: Container(
//                         height: 36,
//                         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                         decoration: BoxDecoration(
//                             border: Border.all(color: const Color(0xff014E70)),
//                             color: const Color(0xffEBF1F4),
//                             borderRadius: BorderRadius.circular(22)),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 8, right: 10),
//                               child: Text(
//                                 "Type",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                               ),
//                             ),
//                             Image.asset(
//                               'assets/icons/arrowdown.png',
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         showModalBottomSheet<void>(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return Container(
//                                 height: size.height * .5,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//                                 child: Center(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 20, right: 20),
//                                         child: Container(
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(color: const Color(0xffDCDCDC)),
//                                                 borderRadius: BorderRadius.circular(15)),
//                                             child: ListTile(
//                                               title: const Text('Arabic'),
//                                               leading: Radio<SingingCharacter>(
//                                                 value: SingingCharacter.lafayette,
//                                                 groupValue: _character,
//                                                 activeColor: const Color(0xff014E70),
//                                                 onChanged: (SingingCharacter? value) {
//                                                   setState(() {
//                                                     _character = value;
//                                                   });
//                                                 },
//                                               ),
//                                             )),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 20, right: 20),
//                                         child: Container(
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(color: const Color(0xffDCDCDC)),
//                                                 borderRadius: BorderRadius.circular(15)),
//                                             child: ListTile(
//                                               title: const Text('English'),
//                                               leading: Radio<SingingCharacter>(
//                                                 value: SingingCharacter.lafayette,
//                                                 groupValue: _character,
//                                                 activeColor: const Color(0xff014E70),
//                                                 onChanged: (SingingCharacter? value) {
//                                                   setState(() {
//                                                     _character = value;
//                                                   });
//                                                 },
//                                               ),
//                                             )),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 20, right: 20),
//                                         child: Container(
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(color: const Color(0xffDCDCDC)),
//                                                 borderRadius: BorderRadius.circular(15)),
//                                             child: ListTile(
//                                               title: const Text('Several languages'),
//                                               leading: Radio<SingingCharacter>(
//                                                 value: SingingCharacter.lafayette,
//                                                 groupValue: _character,
//                                                 activeColor: const Color(0xff014E70),
//                                                 onChanged: (SingingCharacter? value) {
//                                                   setState(() {
//                                                     _character = value;
//                                                   });
//                                                 },
//                                               ),
//                                             )),
//                                       ),
//                                       SizedBox(
//                                         height: size.height * .08,
//                                       ),
//                                       Center(
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(left: 20, right: 20),
//                                           child: Container(
//                                             height: 48,
//                                             width: MediaQuery.sizeOf(context).width,
//                                             color: const Color(0xff014E70),
//                                             child: Center(
//                                               child: Text(
//                                                 'Apply',
//                                                 style: GoogleFonts.poppins(
//                                                     fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             });
//                       },
//                       child: Container(
//                         height: 36,
//                         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                         decoration: BoxDecoration(
//                             border: Border.all(color: const Color(0xff014E70)),
//                             color: const Color(0xffEBF1F4),
//                             borderRadius: BorderRadius.circular(22)),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 8, right: 10),
//                               child: Text(
//                                 "Language",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                               ),
//                             ),
//                             Image.asset(
//                               'assets/icons/arrowdown.png',
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         showModalBottomSheet(
//                             isScrollControlled: true,
//                             context: context,
//                             builder: (context) {
//                               return SizedBox(
//                                 height: size.height * .65,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
//                                       child: Text(
//                                         "Gender",
//                                         style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
//                                       ),
//                                     ),
//                                     Obx(() {
//                                       return Column(
//                                         children: List.generate(
//                                             gender.length,
//                                             (index) => Column(
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   children: [
//                                                     ListTileTheme(
//                                                       horizontalTitleGap: 5,
//                                                       child: CheckboxListTile(
//                                                         controlAffinity: ListTileControlAffinity.leading,
//                                                         dense: true,
//                                                         visualDensity: VisualDensity.compact,
//                                                         activeColor: const Color(0xff014E70),
//                                                         value: gender1[index].isCheck!.value,
//                                                         onChanged: (value) {
//                                                           setState(() {
//                                                             gender1[index].isCheck!.value = value!;
//                                                           });
//                                                         },
//                                                         title: Text(
//                                                           data1[index].title.toString(),
//                                                           style: GoogleFonts.poppins(
//                                                             fontWeight: FontWeight.w500,
//                                                             color: Colors.black,
//                                                             fontSize: 16,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )),
//                                       );
//                                     }),
//                                     SizedBox(
//                                       height: size.height * .2,
//                                     ),
//                                     Align(
//                                       alignment: Alignment.bottomCenter,
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             alignment: Alignment.center,
//                                             height: 48,
//                                             width: MediaQuery.of(context).size.width * .9,
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
//                                             height: 48,
//                                             width: MediaQuery.of(context).size.width * .9,
//                                             decoration: BoxDecoration(border: Border.all(color: AppTheme.buttonColor)),
//                                             child: Text(
//                                               "Clear All",
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     )
//                                   ],
//                                 ),
//                               );
//                             });
//                       },
//                       child: Container(
//                         height: 36,
//                         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                         decoration: BoxDecoration(
//                             border: Border.all(color: const Color(0xff014E70)),
//                             color: const Color(0xffEBF1F4),
//                             borderRadius: BorderRadius.circular(22)),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 8, right: 10),
//                               child: Text(
//                                 "Gender",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                               ),
//                             ),
//                             Image.asset(
//                               'assets/icons/arrowdown.png',
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 SizedBox(
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: 5,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 20, mainAxisExtent: size.height * .35),
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: () {
//                           Get.toNamed(SingleCategoryScreen.route);
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
//                                     'assets/images/notebook.png',
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     'Atrium Classic Backpack Accessory',
//                                     style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//                                   ),
//                                   Text(
//                                     '1 piece',
//                                     style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
//                                   ),
//                                   Text(
//                                     'USD 12.700',
//                                     style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
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
// }
//
// class CheckBoxListTileModel {
//   String title;
//   RxBool? isCheck;
//
//   CheckBoxListTileModel({
//     required this.title,
//     required this.isCheck,
//   });
//
//   static List<CheckBoxListTileModel> getList() {
//     return <CheckBoxListTileModel>[
//       CheckBoxListTileModel(
//         title: "E Book",
//         isCheck: true.obs,
//       ),
//       CheckBoxListTileModel(
//         title: "Voice",
//         isCheck: false.obs,
//       ),
//       CheckBoxListTileModel(
//         title: "Both",
//         isCheck: false.obs,
//       ),
//     ];
//   }
// }
