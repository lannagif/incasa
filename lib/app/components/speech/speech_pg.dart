import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:incasa/app/components/const.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speechToText;
  bool _isListening = false;
  String _text = 'Pressione para falar';
  double _confidence = 0.8;

  final Map<String, HighlightedWord> highlights = {
    'acender': HighlightedWord(
      onTap: () => print('acender'),
      textStyle: TextStyle(
        color: Colors.grey[800],
        fontWeight: FontWeight.bold,
      ),
    ),
    'acenda': HighlightedWord(
      onTap: () => print('acenda'),
      textStyle: TextStyle(
        color: Colors.grey[800],
        fontWeight: FontWeight.bold,
      ),
    ),
    'ligar': HighlightedWord(
      onTap: () => print('ligar'),
      textStyle: TextStyle(
        color: Colors.grey[800],
        fontWeight: FontWeight.bold,
      ),
    ),
    'ligue': HighlightedWord(
      onTap: () => print('ligue'),
      textStyle: TextStyle(
        color: Colors.grey[800],
        fontWeight: FontWeight.bold,
      ),
    ),
    'apagar': HighlightedWord(
      onTap: () => print('apagar'),
      textStyle: TextStyle(
        color: Colors.grey[800],
        fontWeight: FontWeight.bold,
      ),
    ),
    'apague': HighlightedWord(
      onTap: () => print('apague'),
      textStyle: TextStyle(
        color: Colors.grey[800],
        fontWeight: FontWeight.bold,
      ),
    ),
    'desligue': HighlightedWord(
      onTap: () => print('desligue'),
      textStyle: TextStyle(
        color: Colors.grey[800],
        fontWeight: FontWeight.bold,
      ),
    ),
    'desligar': HighlightedWord(
      onTap: () => print('desligar'),
      textStyle: TextStyle(
        color: Colors.grey[800],
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.end,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                    child: TextHighlight(
                      text: _text,
                      words: highlights,
                      textStyle: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            //height: 80,
            //width: 80,
            child: AvatarGlow(
              animate: _isListening,
              glowColor: kPrimaryColor,
              endRadius: 75,
              duration: Duration(milliseconds: 2000),
              repeatPauseDuration: Duration(milliseconds: 100),
              repeat: true,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: kPrimaryColor,
                    size: 40,
                  ),
                  onPressed: _listen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _listen() async {
    if(!_isListening){
      bool available = await _speechToText.initialize(
        onStatus: (val) => print('onStatus $val'),
        onError: (val) => print('onError: $val'),
      );
      if(available){
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (val) => setState((){
            if(val.recognizedWords != ''){
              _text = val.recognizedWords;
            }
            //_text.length > 0 ? _text[0] : '';
            //_text = val.recognizedWords;
            if(val.hasConfidenceRating && val.confidence > 0){
              _confidence = val.confidence;
            }
          }),
        );
      } else {
        setState(() => _isListening = false);
        _speechToText.stop();
      }
    }
  }
}
