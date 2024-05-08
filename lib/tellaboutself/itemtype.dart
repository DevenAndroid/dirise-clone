import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemType extends StatefulWidget {
  const ItemType({super.key});

  @override
  State<ItemType> createState() => _ItemTypeState();
}

class _ItemTypeState extends State<ItemType> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(

            children:[
              Text("Item Type",style:GoogleFonts.poppins(fontSize:20,fontWeight:FontWeight.w500)),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13,),
                child: Text("What’s best that align with your bookable product & service ?",style:GoogleFonts.poppins(fontSize:20)),
              ),
              SizedBox(height: 20,),
              Container(
                width:size.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),

                  image: DecorationImage(
                    image: AssetImage('assets/images/tellus.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                // adjust the width and height as needed
                height: 170,
                child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                  child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children:[
                        Text('Consultation Sessions  ',style:GoogleFonts.poppins(fontSize:30,fontWeight:FontWeight.w500)),
                        Text('General category for one on one appointments',style:GoogleFonts.poppins(fontSize:20)),
                        Text('Doctors, coaches, lawyers, stylists that need scheduling',style:GoogleFonts.poppins(fontSize:20)),
                        Text('Design - personal - Financial Consultation ..etc.',style:GoogleFonts.poppins(fontSize:20))

                      ]),
                )
                ,// add your child widgets here
              ),
              SizedBox(height: 20,),
              Container(
                width:size.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),

                  image: DecorationImage(
                    image: AssetImage('assets/images/tellus (2).png'),
                    fit: BoxFit.cover,
                  ),
                ),
                // adjust the width and height as needed
                height: 170,
                child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                  child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children:[
                        Text('Academic Programs',style:GoogleFonts.poppins(fontSize:30,fontWeight:FontWeight.w500)),
                        Text('Monthly & yearly scheduling for educational programs',style:GoogleFonts.poppins(fontSize:20))

                      ]),
                )
                ,// add your child widgets here
              ),
              SizedBox(height: 20,),
              Container(
                width:size.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),

                  image: DecorationImage(
                    image: AssetImage('assets/images/tellus (3).png'),
                    fit: BoxFit.cover,
                  ),
                ),
                // adjust the width and height as needed
                height: 170,
                child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
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
              // Text("Extra information",),
              // Text("This is an optional step for some products")
            ]

        ),
      ),
    );
  }
}
