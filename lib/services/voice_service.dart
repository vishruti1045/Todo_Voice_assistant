
// lib/services/voice_service.dart
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceService {
  static final stt.SpeechToText _speech = stt.SpeechToText();

  static Future<String> listen() async {
    bool available = await _speech.initialize();
    if (!available) return "";

    String resultText = "";
    await _speech.listen(
      onResult: (result) => resultText = result.recognizedWords,
      localeId: "en_US",
    );

    await Future.delayed(Duration(seconds: 4));
    _speech.stop();
    return resultText;
  }
}
