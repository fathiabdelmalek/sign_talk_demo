import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:takalem_sign_talk_demo/widgets/input_card.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  late final SpeechToText _speechToText;
  bool _speechEnabled = false;
  String _lastWords = '';
  double _confidence = 0;
  final TextEditingController _textEditingController = TextEditingController();
  bool _showCameraButton = true;
  bool _showMicButton = true;

  @override
  void initState() {
    super.initState();
    _speechToText = SpeechToText();
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
              style: const TextStyle(fontSize: 18.0),
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
          Container(
            child: _speechToText.isNotListening && _confidence > 0
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: Text(
                      'Confidence: ${(_confidence * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(bottom: 100.0),
                  ),
          ),
          // InputCard(speechToText: _speechToText),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textEditingController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type a text to translate',
                                contentPadding: EdgeInsets.all(8),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _showCameraButton = value.isEmpty;
                                  _showMicButton = value.isEmpty;
                                });
                              },
                            ),
                          ),
                          if (_showCameraButton)
                            const IconButton(
                              iconSize: 30,
                              onPressed: null,
                              icon: Icon(
                                Icons.camera_alt,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (_showMicButton)
                    AvatarGlow(
                      animate: _speechToText.isListening,
                      glowColor: Colors.purple,
                      child: IconButton.filled(
                        onPressed: _speechToText.isNotListening
                            ? _startListening
                            : _stopListening,
                        iconSize: 30.0,
                        icon: Icon(
                          _speechToText.isNotListening
                              ? Icons.mic_none
                              : Icons.mic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (!_showMicButton)
                    IconButton.filled(
                      iconSize: 30,
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
