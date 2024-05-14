import 'package:dirise/screens/tour_travel/date_range_screen_tour.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Consultation Sessions/date_range_screen.dart';
import 'Extended programs/extended_date_range_screen.dart';
import 'academic programs/date_range_screen.dart';


class TellUsYourSelfScreen extends StatefulWidget {
  const TellUsYourSelfScreen({super.key});

  @override
  State<TellUsYourSelfScreen> createState() => _TellUsYourSelfScreenState();
}

class _TellUsYourSelfScreenState extends State<TellUsYourSelfScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 10),
          child: Column(
        
              children:[
                Text("Item Type",style:GoogleFonts.poppins(fontSize:20,fontWeight:FontWeight.w500)),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13,),
                  child: Text("What’s best that align with your bookable product & service ?",style:GoogleFonts.poppins(fontSize:20)),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Get.to(()=> const DateRangeScreen());
                  },
                  child: Container(
                    width:size.width,
                    decoration:  BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/consultion.png'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF37C666).withOpacity(0.10),
                          offset: const Offset(.1, .1,
                          ),
                          blurRadius: 20.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                   // height: size.height*.26,
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      child: Column(
        
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                          children:[
                            Text('Consultation Sessions  ',style:GoogleFonts.poppins(fontSize:26,fontWeight:FontWeight.w500)),
                            4.spaceY,
                            Text('General category for one on one appointments ',style:GoogleFonts.poppins(fontSize:20)),
                            4.spaceY,
                            Text('Doctors, coaches, lawyers, stylists that need scheduling Design - personal - Financial Consultation ..etc.',style:GoogleFonts.poppins(fontSize:16))
        
                          ]),
                    )
                    ,// add your child widgets here
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Get.to(()=> const AcademicDateScreen());
                  },
                  child: Container(
                    width:size.width,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),

                      image: DecorationImage(
                        image: AssetImage('assets/images/academic.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: size.height*.26,
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children:[
                            Text('Academic Programs',style:GoogleFonts.poppins(fontSize:26,fontWeight:FontWeight.w500)),
                            Text('Monthly & yearly scheduling for educational programs',style:GoogleFonts.poppins(fontSize:20))

                          ]),
                    )
                    ,// add your child widgets here
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>const ExtendedDateRange());
                  },
                  child: Container(
                    width:size.width,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),

                      image: DecorationImage(
                        image: AssetImage('assets/images/extended.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // adjust the width and height as needed
                    height: size.height*.26,
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children:[
                            Text('Extended Programs',style:GoogleFonts.poppins(fontSize:30,fontWeight:FontWeight.w500)),
                            Text('Weekly & Monthly programs',style:GoogleFonts.poppins(fontSize:20)),
                            Text('Flexible scheduling for programs and group training ',style:GoogleFonts.poppins(fontSize:18))

                          ]),
                    )
                    ,// add your child widgets here
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Get.to(()=> const DateRangeScreenTour());
                  },
                  child: Container(
                    width:size.width,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),

                      image: DecorationImage(
                        image: AssetImage('assets/images/tour_travles.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // adjust the width and height as needed
                    height: size.height*.26,
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children:[
                            Text('Tour & Travel',style:GoogleFonts.poppins(fontSize:30,fontWeight:FontWeight.w500)),
                            Text('Focused more on dates & time at a location ',style:GoogleFonts.poppins(fontSize:18))

                          ]),
                    )
                    ,// add your child widgets here
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    width:size.width,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),

                      image: DecorationImage(
                        image: AssetImage('assets/images/class_courses.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // adjust the width and height as needed
                    height: size.height*.26,
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children:[
                            Text('Attendable Seminars, Courses & Classes',style:GoogleFonts.poppins(fontSize:28,fontWeight:FontWeight.w500)),
                            Text('Gather your customers at a location that you choose. ',style:GoogleFonts.poppins(fontSize:18))

                          ]),
                    )
                    ,// add your child widgets here
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    width:size.width,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),

                      image: DecorationImage(
                        image: AssetImage('assets/images/virtual_class.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // adjust the width and height as needed
                    height: size.height*.26,
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children:[
                            Text('Virtual Webinars, Courses & Classes',style:GoogleFonts.poppins(fontSize:28,fontWeight:FontWeight.w500)),
                            Text('Focused more on dates & time at a location ',style:GoogleFonts.poppins(fontSize:18))

                          ]),
                    )
                    ,// add your child widgets here
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    width:size.width,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),

                      image: DecorationImage(
                        image: AssetImage('assets/images/last_img.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // adjust the width and height as needed
                    height: size.height*.26,
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children:[
                            Text('Others',style:GoogleFonts.poppins(fontSize:28,fontWeight:FontWeight.w500)),
                            Text('Use our system to your advantage. If you are not sure, we are happy to hear from you. contact us  ',style:GoogleFonts.poppins(fontSize:18))

                          ]),
                    )
                    ,// add your child widgets here
                  ),
                ),
                // Text("Extra information",),
                // Text("This is an optional step for some products")
              ]
        
          ),
        ),
      ),
    );
  }
}
