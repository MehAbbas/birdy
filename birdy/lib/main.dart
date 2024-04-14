import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Birdy',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  List<String> results = [];
  Set<String> uniqueBirds = {};
  Set<String> allBirds = {"Osprey", "American Crow", "Common Loon", "American Robin"};

  Future<void> callPythonFunction(String inputString) async {
    String url = 'http://10.0.2.2:5000/call_function';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'filename': inputString,
    };

    final response =
        await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> guesses = data['result'];
      setState(() {
        results = guesses.map((guess) => guess['common_name'].toString()).toList(); // Extract common_name from each guess
        uniqueBirds.addAll(results);
      });
    } else {
      setState(() {
        results = ['Failed to call Python function'];
      });
    }
    print(results);
  }

@override
Widget build(BuildContext context) {
  var appState = context.watch<MyAppState>();
  var buttonColor = Color.fromARGB(255, 94, 49, 35);

  return Scaffold(
    
    appBar: AppBar(
      title: Text('birdy'),
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 40, color: const Color.fromARGB(255, 62, 26, 15), fontWeight: FontWeight.bold),
      backgroundColor: Color.fromARGB(255, 255, 249, 230),
    ),
    body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover),
          ),
        ),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                      ),
                      onPressed: () {
                        print("button press");
                        AudioPlayer().play(AssetSource('audio/common_loon.mp3'));
                        callPythonFunction('media/common_loon.mp3');
                      },
                      child: Text('Simulate Loon', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                      ),
                      onPressed: () {
                        print("button press");
                        AudioPlayer().play(AssetSource('audio/crow.mp3'));
                        callPythonFunction('media/crow.mp3');
                      },
                      child: Text('Simulate Crow', style: TextStyle(color: Colors.white),),
                    ),
                  ),]),
            )),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                      ),
                    onPressed: () {
                      print("button press");
                      AudioPlayer().play(AssetSource('audio/osprey.mp3'));
                      callPythonFunction('media/osprey.mp3');
                    },
                    child: Text('Simulate Osprey', style: TextStyle(color: Colors.white),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                      ),
                    onPressed: () {
                      print("button press");
                      AudioPlayer().play(AssetSource('audio/robin.mp3'));
                      callPythonFunction('media/robin.mp3');
                    },
                    child: Text('Simulate Robin', style: TextStyle(color: Colors.white),),
                  ),
                ),])),
          SizedBox(height: 20),
          Card(
            color: const Color.fromARGB(255, 62, 26, 15),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(90.0, 12.0, 90.0, 12.0),
                child: Text(
                  'Most Recently Heard:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
          ),
          SizedBox(height: 10),
          Card(
            color: Color.fromARGB(255, 206, 204, 195),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                results.isNotEmpty ? results.last : 'No birds detected',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            color: const Color.fromARGB(255, 62, 26, 15),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(150.0, 12.0, 150.0, 12.0),
              child: Text(
                'Your Birds:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, backgroundColor: Color.fromARGB(255, 62, 26, 15),),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allBirds.length,
              itemBuilder: (BuildContext context, int index) {
                Widget item = Column(children: [
                ListTile(
                  // You can add more customization to the ListTile here
                )]);
                
                String itemimg = "assets/images/${allBirds.elementAt(index)}.jpg";

                if (uniqueBirds.contains(allBirds.elementAt(index))) {
                  item = Column(children: [
                    Image.asset(itemimg),
                    ListTile(
                      title: Card(
                        color: Color.fromARGB(255, 206, 204, 195),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            allBirds.elementAt(index),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      // You can add more customization to the ListTile here
                    )]);

                }
                return item;
              },
            ),
          ),
        ],
      ),
    )]),
  );
}}