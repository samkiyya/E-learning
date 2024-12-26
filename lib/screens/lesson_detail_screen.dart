import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lesson_provider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class LessonDetailScreen extends StatelessWidget {
  final int lessonId;
  final Uri videoUrl;

  const LessonDetailScreen(
      {super.key, required this.lessonId, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson Details'),
      ),
      body: FutureBuilder<bool>(
        future: lessonProvider.isLessonDownloaded(lessonId.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            final isDownloaded = snapshot.data ?? false;

            return Column(
              children: [
                Expanded(
                  child: isDownloaded
                      ? OfflineVideoPlayer(
                          filePath: lessonProvider.getLessonPath(lessonId.toString())!)
                      : OnlineVideoPlayer(videoUrl: videoUrl),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isDownloaded
                      ? ElevatedButton(
                          onPressed: () {
                            // Play offline video
                          },
                          child: Text('Play Offline'),
                        )
                      : lessonProvider.downloadProgress.containsKey(lessonId) &&
                              lessonProvider.downloadProgress[lessonId]! < 1.0
                          ? DownloadProgressIndicator(lessonId: lessonId.toString())
                          : ElevatedButton(
                              onPressed: () {
                                lessonProvider.downloadLesson(
                                    lessonId.toString(), videoUrl);
                              },
                              child: Text('Download Lesson'),
                            ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class DownloadProgressIndicator extends StatelessWidget {
  final String lessonId;

  const DownloadProgressIndicator({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);
    final progress = lessonProvider.downloadProgress[lessonId] ?? 0.0;

    return Column(
      children: [
        CircularProgressIndicator(value: progress),
        Text('${(progress * 100).toStringAsFixed(0)}%'),
      ],
    );
  }
}

class OfflineVideoPlayer extends StatelessWidget {
  final String filePath;

  const OfflineVideoPlayer({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    final videoPlayerController = VideoPlayerController.file(File(filePath));
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
    );

    return Chewie(controller: chewieController);
  }
}

class OnlineVideoPlayer extends StatelessWidget {
  final Uri videoUrl;

  const OnlineVideoPlayer({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final videoPlayerController = VideoPlayerController.networkUrl(videoUrl);
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
    );

    return Chewie(controller: chewieController);
  }
}
