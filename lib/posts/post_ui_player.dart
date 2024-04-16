import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostVideoPlayer extends StatefulWidget {
  const PostVideoPlayer({super.key, required this.fileUrl});
  final String fileUrl;

  @override
  State<PostVideoPlayer> createState() => _PostVideoPlayerState();
}

class _PostVideoPlayerState extends State<PostVideoPlayer> {

  VideoPlayerController? videoPlayerController;

 ChewieController? chewieController;
 bool videoLoaded = false;

 initializeVideo() async {
   try {
     log("loading Url.....     ${widget.fileUrl}");
     videoPlayerController = VideoPlayerController.networkUrl(
         Uri.parse(widget.fileUrl), videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false,));
     await videoPlayerController!.initialize();
     chewieController = ChewieController(
       videoPlayerController: videoPlayerController!,
       autoPlay: false,
     );
     videoLoaded = true;
     setState(() {});
   } catch(e){
     throw Exception(e);
   }
 }

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  @override
  void dispose() {
    super.dispose();
    if(videoPlayerController != null){
      videoPlayerController!.dispose();
    }
    if(chewieController != null){
      chewieController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return videoLoaded ?
    Chewie(
      controller: chewieController!,
    ) :
    const LoadingAnimation();
  }
}



class PostVideoPlayerFile extends StatefulWidget {
  const PostVideoPlayerFile({Key? key, required this.fileUrl}) : super(key: key);
  final String fileUrl;

  @override
  State<PostVideoPlayerFile> createState() => _PostVideoPlayerFileState();
}

class _PostVideoPlayerFileState extends State<PostVideoPlayerFile> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  bool videoLoaded = false;

  initializeVideo() async {
    File file = File(widget.fileUrl);
    try {
      log("loading Url.....     ${widget.fileUrl}");
      videoPlayerController = VideoPlayerController.file(file);


      await videoPlayerController!.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: false,
      );
      videoLoaded = true;
      setState(() {

      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  @override
  void dispose() {
    super.dispose();
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
    }
    if (chewieController != null) {
      chewieController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return videoLoaded
        ? Chewie(
      controller: chewieController!,
    )
        : const LoadingAnimation();
  }
}
