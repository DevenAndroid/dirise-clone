import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/profile_controller.dart';
import '../../widgets/common_colour.dart';
import 'audio_files_list.dart';
import 'e_books_screen.dart';

class VirtualAssetsScreen extends StatefulWidget {
  static String route = "/VirtualAssetsScreen";
  const VirtualAssetsScreen({Key? key}) : super(key: key);

  @override
  State<VirtualAssetsScreen> createState() => _VirtualAssetsScreenState();
}

class _VirtualAssetsScreenState extends State<VirtualAssetsScreen> with AutomaticKeepAliveClientMixin {

  // getEBooks() {
  //   // repositories.
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  // }
 final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          color: AppTheme.newPrimaryColor,
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    15.spaceX,
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          profileController.selectedLAnguage.value != 'English' ?
                          Image.asset(
                            'assets/images/forward_icon.png',
                            height: 19,
                            width: 19,
                          ) :
                          Image.asset(
                            'assets/images/back_icon_new.png',
                            height: 19,
                            width: 19,
                          ),
                        ],
                      ),
                    ),
                    20.spaceX,
                    Text(
                     AppStrings.eBooks.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: TextField(
                    maxLines: 1,
                    style: GoogleFonts.poppins(fontSize: 17),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        filled: true,
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
                        hintText: AppStrings.search.tr,
                        hintStyle: GoogleFonts.poppins(color: AppTheme.buttonColor)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TabBar(
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                indicator: const BoxDecoration(
                    color: AppTheme.buttonColor, borderRadius: BorderRadius.all(Radius.circular(20))),
                indicatorColor: Colors.transparent,
                unselectedLabelColor: AppTheme.buttonColor,
                labelColor: Colors.white,
                dividerColor: Colors.white,
                labelStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                tabs:  [
                  Tab(
                    text: AppStrings.eBooks.tr,
                  ),
                  Tab(
                    text: AppStrings.voice.tr,
                  ),
                ],
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            // SizedBox(height: 10,),
            const Expanded(
              child: TabBarView(
                children: [
                  EBookListScreen(),
                  AudioFilesListScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
