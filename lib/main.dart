import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:audioplayers/audio_cache.dart';


void main() {
  runApp(MyApp());
}
enum counterIcon {
increment,
  backward,
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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

class _MyHomePageState extends State<MyHomePage> {
  @override

  int urlNo =0;
  List imageList =["assets/images/1.jpg","assets/images/2.jpg","assets/images/3.jpg"];
  List animalNotes =["assets/notes/1.wav","assets/notes/2.wav","assets/notes/3.wav"];
  void checkUrlStatus ({ var IconStatus}){
    setState(() {
      if (urlNo < imageList.length ) {
        // IconStatus == counterIcon.increment?urlNo++ : urlNo--;
        if (IconStatus == counterIcon.increment) {
          urlNo++;
        }
        if (IconStatus == counterIcon.backward) {
          urlNo--;
        }
      }
      if (urlNo == -1 ){
        Alert(
         // buttons: ,
          context: context,
          title: 'Press the Forward Arrow !',
          desc: 'This is the starting of the show ',
        ).show();
        urlNo =0;
      }
      if (urlNo > (imageList.length-1) ){
        Alert(
          content: Column(
            children: <Widget>[
              TextField(decoration: InputDecoration(icon: Icon(Icons.feedback ),labelText: 'Write the feed back here'),)
            ],
          ),

          image: Image.asset(imageList[2]),
          context: context,
          title: 'Finished',
          desc: 'You\'ve reached the end of the Show.',

        ).show();
        urlNo=0;
      }
    });

  }

  void playVoiceNote(){

  }

  final player = AudioCache();
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
       //mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Card(
              //color: Colors.redAccent,
              margin: EdgeInsets.all(10.0),
              child: Image.asset(
                imageList[urlNo],
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Expanded(

            child: RaisedButton(
               child: Row(
                 children: <Widget>[
                   IconButton(icon: Icon(Icons.arrow_back_ios) ,onPressed: (){
                setState(() {
              print('Icon pressed');
              checkUrlStatus(IconStatus: counterIcon.backward);
            });
          },),
                   SizedBox(width: 30.0,),
                   IconButton(,icon: Icon(Icons.arrow_forward_ios) ,onPressed: (){
                     setState(() {
                       print('Ipause con pressed');
                       checkUrlStatus(IconStatus: counterIcon.increment);
                     });
                   },),
                   Text(urlNo.toString()),
                   SizedBox(
                     width: 25.0,
                   ),
                   IconButton(icon: Icon(Icons.music_note),onPressed: (){ setState(() {

                     player.play(animalNotes[urlNo]);
                   });

                   },),


                 ],
               ),



              onPressed: () {
                setState(() {
                  print("presssed");
                });
              }

             ),
            ),


        ],
      ),
    );
  }
}
