import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  double _confidence = 0;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: "ar",
    );
    setState(() {
      _confidence = 0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _confidence = result.confidence;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              _speechToText.isListening
                  ? 'Listening...'
                  : _speechEnabled
                      ? 'Tap the microphone to start listening...'
                      : 'Speech not available',
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          ElevatedButton(
            onPressed:
                _speechToText.isNotListening ? _startListening : _stopListening,
            child: AvatarGlow(
              endRadius: 90.0,
              animate: _speechToText.isListening,
              repeat: true,
              showTwoGlows: true,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(microseconds: 100),
              child: Icon(
                _speechToText.isNotListening ? Icons.mic_none : Icons.mic,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _lastWords,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          if (_speechToText.isNotListening && _confidence > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Text(
                'Confidence: ${(_confidence * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
