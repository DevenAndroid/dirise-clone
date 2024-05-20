import 'package:dirise/widgets/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleProductNew extends StatefulWidget {
  const SingleProductNew({super.key});

  @override
  State<SingleProductNew> createState() => _SingleProductNewState();
}

class _SingleProductNewState extends State<SingleProductNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 10,
        backgroundColor: Color(0xFFF2F2F2),
        surfaceTintColor: Color(0xFFF2F2F2),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              SvgPicture.asset(

                'assets/svgs/arrowb.svg',
                // color: Colors.white,
              ),
              SizedBox(width: 13,),
              SvgPicture.asset(

                'assets/svgs/search.svg',
                // color: Colors.white,
              ),
            ],
          ),
        ),
        leadingWidth: 120,
        // title:  Image.asset(
        //
        //   'assets/svgs/live.png',
        //   // color: Colors.white,
        // ),
        centerTitle: true,
        actions: [
          // ...vendorPartner(),
          const CartBagCard(),
         Icon(Icons.more_vert),
          SizedBox(width: 13,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Color(0xFFFF6868)
                      ,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Text(
                        "  SALE ",
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color:  Color(0xFFFFDF33)),
                      ),
                      Text(
                        "10%",
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color:  Colors.white),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.favorite_border,color: Colors.red,)

              ],
            ),
            Image.asset(

              'assets/svgs/item.png',
              // color: Colors.white,
            ),
            Container(

              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white
                  ,
                  borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(1,1),
                    spreadRadius: 1,
                    color: Colors.grey,
                    blurRadius: 1,

                  )
                ]
              ),
              child: Text(
                "  1/10  ",
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color:  Color(0xFF014E70)),
              ),
            ),
SizedBox(height: 30,),

            SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,

                itemBuilder: (context, index) {
                  return

                 Row(
                   children: [
                     Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF7BBAD6).withOpacity(.16),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Image.asset(

                        'assets/svgs/item.png',height: 100,
                        width: 140,
                        // color: Colors.white,
                      ),
                     ),
                     SizedBox(width: 15,)
                   ],
                 );}
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Set of essentials of fun",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color:  Color(0xFF19313C)),
            ),
            Text(
              "All what you need for a fun and exciting day in the park with your family All what you need for the day at park.. Read ",
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color:  Color(0xFF19313C)),
            ),
            Row(
              children: [
                Text(
                  'KWD 1000',
                  style: GoogleFonts.poppins(decorationColor: Colors.red,
                      decorationThickness: 2,
                      decoration: TextDecoration.lineThrough,

                      color: const Color(0xff19313B),

                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 7,),
                Text.rich(
                  TextSpan(
                    text: '1000.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF19313B),
                    ),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'KWD',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF19313B),
                              ),
                            ),
                            Text(
                              '20',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF19313B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Icon(Icons.star,color: Color(
                    0xFFE0AD60
                ),size: 20,),
                Icon(Icons.star,color: Color(
                    0xFFE0AD60
                ),size: 20,),
                Icon(Icons.star,color: Color(
                    0xFFE0AD60
                ),size: 20,),
                Icon(Icons.star,color: Color(
                    0xFFE0AD60
                ),size: 20,),
                Icon(Icons.star,color: Color(
                    0xFFE0AD60
                ),size: 20,),
              ],
            ),
          ],
        ),
      )
      ,
    );
  }
}
