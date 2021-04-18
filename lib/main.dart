import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'login/login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

final dbRef = FirebaseDatabase.instance.reference();

// var v= await databaseReference.child('FirebaseIOT').once().then(DataSnapshot s{});

// String humidity(){
//   databaseReference.child('FirebaseIOT').once().then((DataSnapshot snapshot)  {
//     print(snapshot.value['humidity'].toString());
//     return snapshot.value['humidity'].toString();
//   });
// }
// Future<String> humidity() async {
//   String result = (await dbRef.instance.reference().child("FirebaseIOT/humidity").once()).value.toString();
//   print(result);
//
//   return Future<String>.delayed(
//       Duration(seconds: 2), () => result);;
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutTube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // 去除右上方Debug標誌
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOption = <Widget>[
    Icon(
      Icons.star,
      size: 100.0,
    ),
    Icon(
      Icons.mood_bad,
      size: 100.0,
    ),
    Icon(
      Icons.wb_sunny,
      size: 100.0,
    ),
  ];
  SnackBar _snackBar1 = SnackBar(content: Text("You Click First Button"));

  void _onItemTap(int index) {
    setState(() => _selectedIndex = index);
  }

  var Button = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ButtonTheme(
        minWidth: 150.0,
        height: 50,
        child: RaisedButton(
          onPressed: () {
            dbRef.child("FirebaseIOT").update({
              'led': '1',
            });
          },
          child: Text('open'),
        ),
      ),
      ButtonTheme(
        minWidth: 150.0,
        height: 50,
        child: RaisedButton(
          onPressed: () {
            dbRef.child("FirebaseIOT").update({
              'led': '0',
            });
          },
          child: Text('close'),
        ),
      ),
    ],
  );
  List<Map<dynamic, dynamic>> lists = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IAQ inspection app"),
        leading: Icon(FontAwesomeIcons.database),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.star, size: 20.0),
      //       title: Text('Star'),
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.mood_bad, size: 20.0), title: Text('Sad')),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.wb_sunny, size: 20.0), title: Text('Sunny')),
      //   ],
      //   onTap: _onItemTap,
      //   currentIndex: _selectedIndex,
      // ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('co2'),
              accountEmail: Text('co2@gmail.com'),
              currentAccountPicture: Image.network(
                  'https://cdn.vox-cdn.com/thumbor/IM3cz1t4VvE13qIHX74frYuGN6M=/0x0:5000x3932/1400x1050/filters:focal(2100x1566:2900x2366):no_upscale()/cdn.vox-cdn.com/uploads/chorus_image/image/65169437/co2.0.jpg'),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Item1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.headset),
              title: Text('Item2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Item3'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: dbRef.onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData) {
              lists.clear();
              DataSnapshot dataValues = snapshot.data.snapshot;
              Map<dynamic, dynamic> values = dataValues.value;
              print(values["FirebaseIOT"].toString());
              values.forEach((key, values) {
                lists.add(values);
              });
              print(lists[0]["temperature"]);
            }
            return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // Flexible(
                          //   child: _widgetOption.elementAt(_selectedIndex),
                          // ),
                          Flexible(
                            child: FadeInImage.assetNetwork(
                                placeholder:'assets/2.jpg',
                                image:'assets/1.jpg'),
                          ),
                          Text(
                            'temperature:'+lists[0]["temperature"].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              fontSize: 20,
                            ),
                          ),Text(
                            'led:'+lists[0]["led"].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              fontSize: 20,
                              
                            ),
                          ),Text(
                            'humidity:'+lists[0]["humidity"].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              fontSize: 20,
                            ),
                          ),Text(
                            'CO2_ppm:'+lists[0]["CO2_ppm"].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              fontSize: 20,
                            ),
                          ),
                          Flexible(child: Button,)

                        ],
                      ),
                    );
          }),
      // Builder(
      //   builder: (BuildContext context) {
      //     return Center(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: <Widget>[
      //           // Flexible(
      //           //   child: _widgetOption.elementAt(_selectedIndex),
      //           // ),
      //           Flexible(
      //             child: FadeInImage.assetNetwork(
      //                 placeholder:'assets/1.jpg',
      //                 image:'https://truth.bahamut.com.tw/s01/202101/5686a83fc52f34a606e2d5df43fe58f8.JPG'),
      //           ),
      //           Text(
      //             humidity().timeout(Duration(seconds: 5)).toString(),
      //             style: TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.w800,
      //               fontFamily: 'Roboto',
      //               letterSpacing: 0.5,
      //               fontSize: 20,
      //             ),
      //           ),
      //           Button,
      //         ],
      //       ),
      //     );
      //   },
      // ),
      // FutureBuilder(
      // future: dbRef.child("FirebaseIOT").once(),
      // builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
      //   if (snapshot.hasData) {
      //     String humidity = snapshot.data.value['humidity'].toString();
      //     String led = snapshot.data.value['led'].toString();
      //     String temperature = snapshot.data.value['temperature'].toString();
      //     return new ListView.builder(
      //         shrinkWrap: true,
      //         itemCount: lists.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           return Card(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 Text("humidity: " + humidity),
      //                 Text("led: "+ led),
      //                 Text("temperature: " +temperature),
      //               ],
      //             ),
      //           );
      //         });
      //   }
      //   return CircularProgressIndicator();
      // }),
    );
  }
}
