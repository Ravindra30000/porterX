import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceAgentScreen extends StatefulWidget {
  const VoiceAgentScreen({Key? key}) : super(key: key);

  @override
  _VoiceAgentScreenState createState() => _VoiceAgentScreenState();
}

class _VoiceAgentScreenState extends State<VoiceAgentScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  WebSocketChannel? _channel;
  String _response = "";
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    // connect to your node proxy server
    _channel = WebSocketChannel.connect(Uri.parse('ws://192.168.1.5:5050')); // use your IP
    _channel!.stream.listen((msg) async {
      setState(() => _response = msg);
      await _flutterTts.speak(msg);
    });
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (result) {
        _channel!.sink.add(result.recognizedWords);
      });
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  @override
  void dispose() {
    _speech.stop();
    _channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Voice Agent')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Response: $_response'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isListening ? _stopListening : _startListening,
              child: Text(_isListening ? 'Stop' : 'Talk to PorterX'),
            ),
          ],
        ),
      ),
    );
  }
}
