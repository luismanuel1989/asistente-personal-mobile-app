import 'package:controlVoiceApp/sensors.dart';
import 'package:controlVoiceApp/settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:web_scraper/web_scraper.dart';

class MyHomePage extends StatefulWidget {
  String fullName;
  MyHomePage({Key key, this.title,this.fullName}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


dynamic languagesSpk;

const languages = const [
  const Language('Francais', 'fr_FR'),
  const Language('English', 'en_US'),
  const Language('Pусский', 'ru_RU'),
  const Language('Italiano', 'it_IT'),
  const Language('Español', 'es_ES'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

enum TtsState { playing, stopped }
class _MyHomePageState extends State<MyHomePage> {
  bool isComand = false;
  int currentNew = 0;
  var news = <String>[];
  String _newVoiceText;
  TtsState ttsState = TtsState.stopped;
  String language;
  FlutterTts flutterTts = FlutterTts();
  SpeechRecognition _speech;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  double volume = 0.5;
  double pitch = 1;
  double rate = 1.3;
  String transcription = '';

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;
  int _counter = 0;

  void initChaptersTitleScrap() async {
    final rawUrl =
        'http://www.cubadebate.cu/noticias/';
    final webScraper = WebScraper('http://www.cubadebate.cu');
    final endpoint = rawUrl.replaceAll(r'http://www.cubadebate.cu', '');
    if (await webScraper.loadWebPage(endpoint)) {
      final titleNormalImageElements = webScraper.getElement(
          'div#archive > div.image_post > div.title > a',
          []);
      final titleBigImageElements = webScraper.getElement(
          'div#archive > div.bigimage_post > div.title > a',
          []);

      titleNormalImageElements.forEach((element) {
        final title = element['title'];
        news.add('$title');
      });
      titleBigImageElements.forEach((element) {
        final title = element['title'];
        news.add('$title');
      });

      // await _speak(news[currentNew]);
      currentNew++;

      print(news.length);
      if (mounted)
        setState(() {
          //  this.titleList = titleList;
        });
    } else {
      print('Cannot load url');
    }
  }

  @override
  initState() {
    news = [];
    super.initState();
    activateSpeechRecognizer();
    configurePushNotification();
    initTTS();
    initChaptersTitleScrap();
    _speak("Hola Martin Bienvenido,soy lisa, que quieres que haga?");

  }
  Future<void> initTTS() async {

    flutterTts = FlutterTts();
    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });
    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        if(currentNew < news.length && isComand==true) {
          _speak(news[currentNew]);
          currentNew++;
        }
        ttsState = TtsState.stopped;
      });
    });
    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });

    //await _speak("Hola Martin este es tu asistente personal");

  }
  Future _getLanguages() async {
    languagesSpk = await flutterTts.getLanguages;
    print("pritty print ${languages}");
    if (languages != null) setState(() => languages);
  }
  Future _speak(String txtStr) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    _newVoiceText = txtStr;
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }
  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }
  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
  configurePushNotification() {

    _firebaseMessaging.getToken().then((token) async {
      print("Token Forebase"+token);
      /*
    final http.Response response =
    await http.post(UrlAddress.urlDeveloper + "/updateFCMToken",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "firebaseId": currentUser.id,
          "fcmToken": token,
        }));

    if(response.statusCode == 200){
      print("Token Updated");
    }else{
      print("Token not Updated");
    }
     */
    });
  }
// Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(widget.fullName,style: TextStyle(color: Colors.white,fontSize: 18)),
              decoration: BoxDecoration(
                  color: Colors.blue
              ),
            ),
            ListTile(
              trailing: Icon(Icons.person_outline),
              title: Text("Mi perfil"),
              onTap: (){

              },
            ),
            ListTile(
              selected: true,
              hoverColor: Colors.blue,
              focusColor: Colors.blue,
              trailing: Icon(Icons.mic),
              title: Text("Comandos de Voz"),
              onTap: (){

              },
            ),
            ListTile(
              trailing: Icon(Icons.gradient),
              title: Text("Sensores"),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (_) => Sensors()));
              },
            ),
            ListTile(
              trailing: Icon(Icons.lightbulb_outline),
              title: Text("Actuadores"),
              onTap: (){

              },
            ),
            ListTile(
              trailing: Icon(Icons.settings),
              title: Text("Configuraciones"),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (_) => Settings()));
              },
            ),
            ListTile(
              trailing: Icon(Icons.accessibility_new),
              title: Text("Lista de acciones"),
              onTap: (){

              },
            )
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text('SpeechRecognition'),
        actions: [
          new PopupMenuButton<Language>(
            onSelected: _selectLangHandler,
            itemBuilder: (BuildContext context) => _buildLanguagesWidgets,
          )
        ],
      ),
      body: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Center(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                new Expanded(
                    child: new Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.grey.shade200,
                        child: new Text(transcription))),
                _buildButton(
                  onPressed: _speechRecognitionAvailable && !_isListening
                      ? () => start()
                      : null,
                  label: _isListening
                      ? 'Listening...'
                      : 'Listen (${selectedLang.code})',
                ),
                _buildButton(
                  onPressed: _isListening ? () => cancel() : null,
                  label: 'Cancel',
                ),
                _buildButton(
                  onPressed: _isListening ? () => stop() : null,
                  label: 'Stop',
                ),
              ],
            ),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
      .map((l) => new CheckedPopupMenuItem<Language>(
    value: l,
    checked: selectedLang == l,
    child: new Text(l.name),
  ))
      .toList();

  void _selectLangHandler(Language lang) {
    setState(() => selectedLang = lang);
  }

  Widget _buildButton({String label, VoidCallback onPressed}) => new Padding(
      padding: new EdgeInsets.all(12.0),
      child: new RaisedButton(
        color: Colors.cyan.shade600,
        onPressed: onPressed,
        child: new Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ));

  void start() => _speech
      .listen(locale: selectedLang.code)
      .then((result) =>{
    print('_MyAppState.start => result ${result}')
  });

  void cancel() =>
      _speech.cancel().then((result) => setState(() => _isListening = result));

  void stop() =>
      _speech.stop().then((result) => setState(() => _isListening = result));

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    setState(
            () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) {

    setState(() => transcription = text);
    if(transcription.toString().contains("encender")){
      //   print("Reconociendo..."+transcription);
      Fluttertoast.showToast(msg: "Encendiendo Luces",
          toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16);
    }
    if(transcription.toString().contains("noticias") && transcription.toString().contains("Lisa")){
      _speech.stop();
      isComand = true;
      _speak(news[currentNew]);
      currentNew++;
    }
    else if(transcription.toString().contains("temperatura") && transcription.toString().contains("Lisa")){
      _speech.stop();
      _speak("La temperatura es de 31 grados celcius");
    }
    else if(transcription.toString().contains("apagar")){
      Fluttertoast.showToast(msg: "Apagando Luces",
          toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16);
    }

  }

  void onRecognitionComplete() => setState(() => _isListening = false);
}