import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:incasa/app/components/const.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:incasa/app/services/database.dart';

import 'package:provider/provider.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';

class SpeechScreen extends StatefulWidget {

  //SpeechScreen({this.dispositivo});

  //final Dispositivo dispositivo;

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speechToText;
  bool _isListening = false;
  String _text = 'Pressione \u{1f3A4} para falar';
  double _confidence = 0.8;

/*  final Map<String, HighlightedWord> highlights = {
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
  };*/

  final List acender = [
    'acender',
    'acenda',
    'ligar',
    'ligue',
  ];

  final List apagar = [
    'apagar',
    'apague',
    'desligar',
    'desligue',
  ];

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
                    child: Text(
                      _text,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    /*
                    child: TextHighlight(
                      text: _text,
                      words: highlights,
                      textStyle: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),*/
                  ),
                );
              },
            ),
          ),
          Container(
              //height: 80,
              //width: 80,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            AvatarGlow(
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
            AvatarGlow(
              animate: _text != 'Pressione' + Icon(Icons.mic_none_outlined).toStringShort() + 'para falar',
              glowColor: kPrimaryColor,
              endRadius: 75,
              duration: Duration(milliseconds: 2000),
              repeatPauseDuration: Duration(milliseconds: 100),
              repeat: true,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(
                    _text != "Pressione para falar"
                        ? Icons.play_arrow
                        : Icons.stop,
                    color: kPrimaryColor,
                    size: 40,
                  ),
                  onPressed: _execute,
                ),
              ),
            ),
          ])),
        ],
      ),
    );
  }

  void inverterListenerState() {
    setState(() {
      _isListening = !_isListening;
      _text = 'Pressione para falar';
    });
  }

  void _execute() async {
    print(_text);
    if (_text.split(' ').length > 0) {
      List<String> _palavras = _text.split(' ');
      for (final palavra in _palavras) {
        print("{$palavra}");
        if (acender.contains(palavra.toLowerCase()) ||
            apagar.contains(palavra.toLowerCase())) {
          print("{$_palavras}");
          await processState(_palavras);
          break;
        } else {
          print('Comando não reconhecido 1');
        }
      }
    }
  }

  void processState(List<String> _palavras) async {
    if (acender.contains(_palavras[0].toLowerCase())) {
      await changeState(1, _palavras[1]);
    } else if (apagar.contains(_palavras[0].toLowerCase())) {
      await changeState(0, _palavras[1]);
    } else {
      print('Comando não reconhecido');
    }
  }

  void changeState(int state, String tag) async {
    final database = Provider.of<Database>(context, listen: false);
    final dispositivos = await database.dispositivoStream().first;

    print(tag);
    print(dispositivos);

    for(final dispositivo in dispositivos){
      if(dispositivo.tag.toLowerCase() == tag.toLowerCase()){
        dispositivo.estado = state;
        database.setDispositivo(dispositivo);
        print(state);
        break;
      }
    }

    //List<DocumentSnapshot> documentList;


    // var documentList = (await FirebaseFirestore.instance
    //     .collection("dispositivos")
    //     .where("tag", isEqualTo: tag));
    //
    // documentList.get().then((querySnapshot) => {documentList});
    // //.get().then((snapshot) => snapshot.docs)).toList();
    // print(documentList);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (val) => print('onStatus $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (val) => setState(() {
            if (val.recognizedWords != '') {
              _text = val.recognizedWords;
            }

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speechToText.stop();
    }
  }
}
