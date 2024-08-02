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
        backgroundColor: const Color(0xFFF2F2F2),
        surfaceTintColor: const Color(0xFFF2F2F2),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              SvgPicture.asset(

                'assets/svgs/arrowb.svg',
                // color: Colors.white,
              ),
              const SizedBox(width: 13,),
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
         const Icon(Icons.more_vert),
          const SizedBox(width: 13,),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
        
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFF6868)
                        ,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Text(
                          "  Final price ",
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color:  const Color(0xFFFFDF33)),
                        ),
                        Text(
                          "10%",
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color:  Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.favorite_border,color: Colors.red,)
        
                ],
              ),
              Image.asset(
        
                'assets/svgs/item.png',
                // color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: Container(

                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white
                      ,
                      borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      const BoxShadow(
                        offset: Offset(1,1),
                        spreadRadius: 1,
                        color: Colors.grey,
                        blurRadius: 1,

                      )
                    ]
                  ),
                  child: Text(
                    "  1/10  ",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color:  const Color(0xFF014E70)),
                  ),
                ),
              ),
        const SizedBox(height: 30,),
        
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
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7BBAD6).withOpacity(.16),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Image.asset(
        
                          'assets/svgs/item.png',height: 100,
                          width: 140,
                          // color: Colors.white,
                        ),
                       ),
                       const SizedBox(width: 15,)
                     ],
                   );}
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: Text(
                  "Set of essentials of fun",
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color:  const Color(0xFF19313C)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: Text(
                  "All what you need for a fun and exciting day in the park with your family All what you need for the day at park.. Read ",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color:  const Color(0xFF19313C)),
                ),
              ),
              const SizedBox(height: 6,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(

                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFF0000),
                          borderRadius: BorderRadius.circular(15),

                      ),
                      child: Text(
                        "  1.5%  ",
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color:  Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
        
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: Row(
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
                    const SizedBox(width: 7,),
                    const Text.rich(
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
                    const Spacer(),
                    const Icon(Icons.star,color: Color(
                        0xFFE0AD60
                    ),size: 20,),
                    const Icon(Icons.star,color: Color(
                        0xFFE0AD60
                    ),size: 20,),
                    const Icon(Icons.star,color: Color(
                        0xFFE0AD60
                    ),size: 20,),
                    const Icon(Icons.star,color: Color(
                        0xFFE0AD60
                    ),size: 20,),
                    const Icon(Icons.star,color: Color(
                        0xFFE0AD60
                    ),size: 20,),
                  ],
                ),
              ),
        
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.1)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color:  const Color(0xFF014E70)),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        const Icon(Icons.circle,size: 10,color: Colors.grey,),
                        const SizedBox(width: 14,),
                        Text(
                          "Up to 70% off. Free shipping on 1st order",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color:  const Color(0xFF000000).withOpacity(0.5)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        const Icon(Icons.circle,size: 10,color: Colors.grey,),
                        const SizedBox(width: 14,),
                        Text(
                          "Shipping Type",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color:  const Color(0xFF000000).withOpacity(0.5)),
                        ),
                        Text(
                          "May 12-15",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color:  const Color(0xFF014E70)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        const Icon(Icons.circle,size: 10,color: Colors.grey,),
                        const SizedBox(width: 14,),
                        Text(
                          "price and date shipping standard",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color:  const Color(0xFF000000).withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.only(left: 7,right: 7),
          decoration: BoxDecoration(
              color: Colors.white
              ,
              borderRadius: BorderRadius.circular(0),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1,1),
                  spreadRadius: 3,
                  color: Colors.grey.shade300,
                  blurRadius: 3,

                )
              ]
          ),
          child: Row(
            children: [
              Text(
                "Quantity : ",
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color:  const Color(0xFF000000)),
              ),
              const Spacer(),
              Text(
                "15 Left",
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color:  const Color(0xFFFF0000)),
              ),
              const SizedBox(width: 20,),
              Text(
                "-",
                style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w500, color:  const Color(0xFF014E70)),
              ),
              const SizedBox(width: 10,),
              Text(
                "1",
                style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w500, color:  const Color(0xFF014E70)),
              ),
              const SizedBox(width: 10,),
              Text(
                "+",
                style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w500, color:  const Color(0xFF014E70)),
              ),
            ],
          ),
        ),
const SizedBox(height: 10,),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: Text(
                  "Specifications",
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color:  const Color(0xFF000000)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 10),
                child:                     Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Brand :",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color:  const Color(0xFF000000)),
                    ),
                    const SizedBox(width: 20,),
                    const Icon(Icons.circle,size: 10,color: Colors.grey,),
                    const SizedBox(width: 14,),
                    Expanded(
                      child: Text(
                        "No Brand",
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color:  const Color(0xFF000000).withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 10),
                child:                     Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SKU :",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color:  const Color(0xFF000000)),
                    ),
                    const SizedBox(width: 20,),
                    const Icon(Icons.circle,size: 10,color: Colors.grey,),
                    const SizedBox(width: 14,),
                    Expanded(
                      child: Text(
                        "4664548844874844",
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color:  const Color(0xFF000000).withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 10),
                child:                     Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Service :",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color:  const Color(0xFF000000)),
                    ),
                    const SizedBox(width: 20,),
                    const Icon(Icons.circle,size: 10,color: Colors.grey,),
                    const SizedBox(width: 14,),
                    Expanded(
                      child: Text(
                        "(7 days free & easy return) Seller Policy ",
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color:  const Color(0xFF000000).withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.grey,),

              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: Text(
                  "Specifications",
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color:  const Color(0xFF000000)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8,top: 10),
                child:                     Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Location :",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color:  const Color(0xFF000000)),
                    ),
                    const SizedBox(width: 20,),
                    const Icon(Icons.circle,size: 10,color: Colors.grey,),
                    const SizedBox(width: 14,),
                    Expanded(
                      child: Text(
                        "Kuwait City,(Choose MAP)",
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color:  const Color(0xFF014E70)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8,top: 10),
                child:                     Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SKU :",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color:  const Color(0xFF000000)),
                    ),
                    const SizedBox(width: 20,),
                    const Icon(Icons.circle,size: 10,color: Colors.grey,),
                    const SizedBox(width: 14,),
                    Expanded(
                      child: Text(
                        "4664548844874844",
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color:  const Color(0xFF000000).withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8,top: 10),
                child:                     Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Service :",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color:  const Color(0xFF000000)),
                    ),
                    const SizedBox(width: 20,),
                    const Icon(Icons.circle,size: 10,color: Colors.grey,),
                    const SizedBox(width: 14,),
                    Expanded(
                      child: Text(
                        "(7 days free & easy return) Seller Policy ",
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color:  const Color(0xFF000000).withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
      ,
    );
  }
}
