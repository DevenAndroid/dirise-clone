
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../iAmHereToSell/productAccountCreatedSuccessfullyScreen.dart';
import '../screens/tell_us_about_yourself.dart';
import '../singleproductScreen/varientsProductsScreen.dart';
import '../vendor/products/add_product/add_product_screen.dart';
import '../vendor/products/add_product/variant_product/varient_product.dart';

class ExtraInformation extends StatefulWidget {
  const ExtraInformation({super.key});
  static var route = "/ExtraInformation";
  @override
  State<ExtraInformation> createState() => _ExtraInformationState();
}

class _ExtraInformationState extends State<ExtraInformation> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
          
            children:[
              Text("Extra information",style:GoogleFonts.poppins(fontSize:20,fontWeight:FontWeight.w500)),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13,),
                child: Text("This is an optional step for some products ",style:GoogleFonts.poppins(fontSize:20)),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Get.to(()=>const ProductAccountCreatedSuccessfullyScreen());
                },
                child: Container(
                  width:size.width,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage('assets/images/tellus.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                     // adjust the width and height as needed
                    height: 180,
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      child: Column(
          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                          children:[
                        Text('I’am Done ',style:GoogleFonts.poppins(fontSize:30,fontWeight:FontWeight.w500)),
                        Text('Nothing more to add Publish it, I might edit later :) ',style:GoogleFonts.poppins(fontSize:20))
          
                      ]),
                    )
                  ,// add your child widgets here
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                   // Get.to(()=> VarientProductsScreen(productType: 'variants',));
                  Get.to(AddProductScreen());
                },
                child: Container(
                  width:size.width,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
          
                    image: DecorationImage(
                      image: AssetImage('assets/images/tellus (2).png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // adjust the width and height as needed
                  height: 170,
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                    child: Column(
          
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                        children:[
                          Text('Variable',style:GoogleFonts.poppins(fontSize:30,fontWeight:FontWeight.w500)),
                          Text('My item have variable shape, size, color, price, material...etc',style:GoogleFonts.poppins(fontSize:20))
          
                        ]),
                  )
                  ,// add your child widgets here
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Get.to(()=>const TellUsYourSelfScreen());
                },
                child: Container(
                  width:size.width,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),

                    image: DecorationImage(
                      image: AssetImage('assets/images/tellus (3).png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // adjust the width and height as needed
                  height: 170,
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                    child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children:[
                          Text('Bookable',style:GoogleFonts.poppins(fontSize:30,fontWeight:FontWeight.w500)),
                          Text('I Need to set times, availability, offs, & locations ..etc',style:GoogleFonts.poppins(fontSize:20))

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
