import 'dart:developer';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/product_model/model_product_element.dart';
import '../../widgets/loading_animation.dart';
import '../app_bar/common_app_bar.dart';

class SingleCategoryScreen extends StatefulWidget {
  final ProductElement product;
  const SingleCategoryScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<SingleCategoryScreen> createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> animation;

  ProductElement get product => widget.product;

  Duration totalDuration = Duration.zero;
  AudioPlayer audioPlayer = AudioPlayer();

  Stream<AudioEvent> audioStream = const Stream.empty();


  getDuration() async {
    totalDuration = (await audioPlayer.getDuration()) ?? Duration.zero;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    audioStream = audioPlayer.eventStream;
    audioPlayer.play(UrlSource(product.virtualProductFile),mode: PlayerMode.mediaPlayer).then((value){
      getDuration();
      audioPlayer.setReleaseMode(ReleaseMode.loop);
    });
  }
  bool playing = false;

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
    audioPlayer.dispose();
    animationController.dispose();
  }

  String getDurationInTime(){
    int seconds = totalDuration.inSeconds % 60;
    int minutes = totalDuration.inMinutes % 60;
    int hours = totalDuration.inHours % 24;
    if(hours == 0){
      return "${minutes < 10 ? "0$minutes" : minutes}m : ${seconds < 10 ? "0$seconds" : seconds}s";
    }
    return "${hours < 10 ? "0$hours" : hours}h : ${minutes < 10 ? "0$minutes" : minutes} : ${seconds < 10 ? "0$seconds" : seconds}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        titleText: "",
        backGroundColor: AppTheme.buttonColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.maxFinite,
              color: AppTheme.buttonColor,
              padding: const EdgeInsets.all(20),
              child: Hero(
                tag: product.featuredImage.toString(),
                child: Material(
                    color: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    child: Image.network(product.featuredImage.toString())),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              product.pName.toString().capitalize!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(product.shortDescription.toString(),
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey.shade700)),
            const SizedBox(
              height: 30,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xffE8E8E8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Eng',
                            style:
                                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: AppTheme.buttonColor),
                          ),
                          Text('Language'.tr, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xffE8E8E8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getDurationInTime(),
                            style:
                                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: AppTheme.buttonColor),
                          ),
                          Text(AppStrings.audio, style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        color: Colors.grey.shade300,
        alignment: Alignment.center,
        child: StreamBuilder(
          stream: audioStream, builder: (BuildContext context, AsyncSnapshot<AudioEvent> snapshot) {
          if(snapshot.hasData){
            if(snapshot.data ==null){
              return const LoadingAnimation();
            }
            log("Player Info.....    ${snapshot.data!.eventType}");
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 5,),
                IconButton(
                    onPressed: (){
                      if(playing){
                        audioPlayer.pause();
                        playing = false;
                        animationController.reverse();
                        setState(() {});
                        return;
                      }
                      audioPlayer.resume();
                      playing = true;
                      animationController.forward();
                      setState(() {});

                    },
                    icon: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        size: 50,
                        color: Colors.black,
                        progress: animation,
                    )
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18).copyWith(top: 20,left: 5),
                    child: ProgressBar(
                      progress: snapshot.data!.position ?? Duration.zero,
                      buffered: Duration.zero,
                      total: totalDuration,
                      onSeek: (duration) {
                        audioPlayer.seek(duration);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const LoadingAnimation();
        },

        ),
      ),
    );
  }
}
