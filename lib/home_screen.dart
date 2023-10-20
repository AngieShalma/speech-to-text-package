import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart'as stts;
class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override

  var _speechToText=stts.SpeechToText();
  bool islisteing=false;
  String text="please press the button for speaking";
  void listen()async{
    if(!islisteing){
     bool avalible=await _speechToText.initialize(
        onStatus: (status) => print("$status"),
        onError: (errorNotification) => print("$errorNotification"),
      );
     if(avalible){
       setState(() {
         islisteing=true;
       });
       _speechToText.listen(
         onResult: (result) => setState(() {
           text=result.recognizedWords;
         }),
       );
     }

    }else{
      setState(() {
        islisteing=false;
      });
      _speechToText.stop();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speechToText=stts.SpeechToText();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("speech to text",style: TextStyle(
          color: Colors.white,
          //fontWeight: FontWeight.bold
        ),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius:80 ,
        repeat: true,
        animate: islisteing,
        duration: Duration(microseconds: 1000),
        glowColor: Colors.blue,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,

          onPressed: (){
            listen();
          },
          child: Icon(islisteing?Icons.mic:Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Text(text),
        ),
      ),
    );
  }
}
