
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

class LessonProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final Dio _dio = Dio();

  Map<String, String> _downloadedLessons = {};

  Map<String, String> get downloadedLessons => _downloadedLessons;

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
      await _dio.download(url as String, filePath);
      await _secureStorage.write(key: lessonId, value: filePath);
      _downloadedLessons[lessonId] = filePath;
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