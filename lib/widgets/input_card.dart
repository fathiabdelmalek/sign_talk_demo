import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart';

class InputCard extends StatefulWidget {
  final TextEditingController textEditingController;
  final SpeechToText speech;
  final VoidCallback startListening;
  final VoidCallback stopListening;
  final VoidCallback onSend;

  const InputCard({
    Key? key,
    required this.textEditingController,
    required this.speech,
    required this.startListening,
    required this.stopListening,
    required this.onSend,
  }) : super(key: key);

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  bool _showCameraButton = true;
  bool _showMicButton = true;

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
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: widget.textEditingController,
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
                animate: widget.speech.isListening,
                glowColor: Colors.purple,
                child: IconButton.filled(
                  onPressed: widget.speech.isNotListening
                      ? widget.startListening
                      : widget.stopListening,
                  iconSize: 30.0,
                  icon: Icon(
                    widget.speech.isNotListening
                        ? Icons.mic_none
                        : Icons.mic,
                    color: Colors.white,
                  ),
                ),
              ),
            if (!_showMicButton)
              IconButton.filled(
                iconSize: 30,
                onPressed: widget.onSend,
                icon: const Icon(Icons.send),
              ),
          ],
        ),
      ),
    );
  }
}
