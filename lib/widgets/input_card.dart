import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class InputCard extends StatefulWidget {
  final SpeechToText speechToText;

  const InputCard({
    Key? key,
    required this.speechToText,
  }) : super(key: key);

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _showCameraButton = true;
  bool _showMicButton = true;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    final bool isAvailable = await widget.speechToText.initialize();
    if (isAvailable) {
      setState(() {});
    }
  }

  void _startListening() async {
    await widget.speechToText.listen(
      onResult: _onSpeechResult,
      localeId: "ar",
    );
    setState(() {});
  }

  void _stopListening() async {
    await widget.speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                animate: widget.speechToText.isListening,
                glowColor: Colors.purple,
                child: IconButton.filled(
                  onPressed: widget.speechToText.isNotListening
                      ? _startListening
                      : _stopListening,
                  iconSize: 30.0,
                  icon: Icon(
                    widget.speechToText.isNotListening
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
    );
  }
}
