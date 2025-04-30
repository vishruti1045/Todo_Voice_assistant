// lib/services/tts_service.dart
import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  static final _tts = FlutterTts();

  static Future<void> speak(String message) async {
    await _tts.speak(message);
  }
}