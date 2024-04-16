// import 'dart:async';
// import 'dart:developer';
//
// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:dirise/screens/app_bar/common_app_bar.dart';
// import 'package:dirise/widgets/loading_animation.dart';
// import 'package:flutter/material.dart';
//
// import '../model/order_models/model_single_order_response.dart';
//
// class AudioPlayerScreen extends StatefulWidget{
//   const AudioPlayerScreen({super.key, required this.orderItem});
//
//   final OrderItem orderItem;
//
//   @override
//   State<StatefulWidget> createState() {
//     return AudioPlayerScreenState();
//   }
// }
// class AudioPlayerScreenState extends State<AudioPlayerScreen>{
//
//   OrderItem get product => widget.orderItem;
//   AudioPlayer audioPlayer = AudioPlayer();
//   // final player = AudioPlayer();
//   // await player.play(UrlSource('https://example.com/my-audio.wav'));
//
//   Stream<AudioEvent> audioStream = const Stream.empty();
//
//   Duration totalDuration = Duration.zero;
//
//   getDuration() async {
//     totalDuration = (await audioPlayer.getDuration()) ?? Duration.zero;
//     print("total Duration.....       $totalDuration");
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     audioStream = audioPlayer.eventStream;
//     audioPlayer.play(UrlSource(product.virtual_product_file),mode: PlayerMode.mediaPlayer).then((value){
//       getDuration();
//       audioPlayer.setReleaseMode(ReleaseMode.loop);
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     audioPlayer.stop();
//     audioPlayer.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CommonAppBar(
//         titleText: product.productName,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(onPressed: () async {
//                 if(audioPlayer.state == PlayerState.paused){
//                   print("Playing......................");
//                   await audioPlayer.resume();
//                 }
//                 // if(audioPlayer.state == PlayerState.playing){
//                 //   print("Paused......................");
//                 //   await audioPlayer.pause();
//                 // }
//                 setState(() {});
//               }, icon: const Icon(Icons.play_circle_fill_rounded,size: 30,)),
//               IconButton(onPressed: () async {
//                 await audioPlayer.pause();
//               }, icon: const Icon(Icons.pause_circle_filled_rounded,size: 30,)),
//             ],
//           ),
//           const SizedBox(height: 10,),
//           StreamBuilder(
//             stream: audioStream, builder: (BuildContext context, AsyncSnapshot<AudioEvent> snapshot) {
//               if(snapshot.hasData){
//                 if(snapshot.data ==null){
//                   return const LoadingAnimation();
//                 }
//                 log("Player Info.....    ${snapshot.data!.eventType}");
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 18),
//                   child: ProgressBar(
//                     progress: snapshot.data!.position ?? Duration.zero,
//                     buffered: Duration.zero,
//                     total: totalDuration,
//                     onSeek: (duration) {
//                       audioPlayer.seek(duration);
//                     },
//                   ),
//                 );
//               }
//               return const LoadingAnimation();
//           },
//
//           ),
//         ],
//       ),
//     );
//   }
//
// }