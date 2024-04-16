import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_colour.dart';

class PublicSpeakerScreen extends StatefulWidget {
  const PublicSpeakerScreen({Key? key}) : super(key: key);
  static var route = "/publicSpeaker";

  @override
  State<PublicSpeakerScreen> createState() => _PublicSpeakerScreenState();
}

class _PublicSpeakerScreenState extends State<PublicSpeakerScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          color: AppTheme.buttonColor,
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      'Public Speaker'.tr,
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: TextField(
                    maxLines: 1,
                    style: GoogleFonts.poppins(fontSize: 17),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        filled: true,
                        // prefixIcon:
                        //     Icon(Icons.search, color: Color(0xFFC33D18)),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/icons/search.png',
                            height: 3,
                          ),
                        ),
                        border: InputBorder.none,
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(color: AppTheme.buttonColor)),
                        disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(color: AppTheme.buttonColor)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(color: AppTheme.buttonColor)),
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 60),
                        hintText: 'Search Public Speaker'.tr,
                        hintStyle: GoogleFonts.poppins(color: AppTheme.buttonColor)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      // mainAxisSpacing: 10,
                      childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.7)),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(PublicSpeakerScreen.route);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              height: size.height * .2,
                              'assets/images/teacher1.png',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Jarir Library '.tr,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '1457 ${'Items'.tr}',
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
