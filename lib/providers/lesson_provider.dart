import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

class LessonProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final Dio _dio = Dio();

  Map<String, String> _downloadedLessons = {};
  Map<String, double> _downloadProgress = {}; // Track download progress

  Map<String, String> get downloadedLessons => _downloadedLessons;
  Map<String, double> get downloadProgress => _downloadProgress;

  LessonProvider() {
    _loadDownloadedLessons();
  }

  Future<void> _loadDownloadedLessons() async {
    final allEntries = await _secureStorage.readAll();
    _downloadedLessons = allEntries.map((key, value) => MapEntry(key, value));
    notifyListeners();
  }

  Future<void> downloadLesson(String lessonId, Uri url) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$lessonId.mp4';

    try {
      _downloadProgress[lessonId] = 0.0; // Initialize progress
      notifyListeners();

      await _dio.download(
        'https://backend.biomedicalhorizonnetwork.com/$url',
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            _downloadProgress[lessonId] = (received / total);
            notifyListeners(); // Update progress
          }
        },
      );

      await _secureStorage.write(key: lessonId, value: filePath);
      _downloadedLessons[lessonId] = filePath;
      _downloadProgress[lessonId] = 1.0; // Mark download as complete
      notifyListeners();
    } catch (e) {
      debugPrint("Download error: $e");
    }
  }

  Future<bool> isLessonDownloaded(String lessonId) async {
    return _downloadedLessons.containsKey(lessonId);
  }

  String? getLessonPath(String lessonId) {
    return _downloadedLessons[lessonId];
  }
}
