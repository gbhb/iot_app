import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
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
    Icon(Icons.star, size: 100.0,),
    Icon(Icons.mood_bad, size: 100.0,),
    Icon(Icons.wb_sunny, size: 100.0,),
  ];
  SnackBar _snackBar1 = SnackBar(content: Text("You Click First Button"));


  void _onItemTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Scaffold example"),
          leading: Icon(FontAwesomeIcons.database),
        ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.star,size: 20.0), title: Text('Star'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.mood_bad,size: 20.0), title: Text('Sad')),
          BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny,size: 20.0), title: Text('Sunny')),
        ],
          onTap: _onItemTap,
          currentIndex: _selectedIndex,),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('oil'),
                accountEmail: Text('userGmail@gmail.com'),
                currentAccountPicture: Image.network('https://img.mttmp.com/images/2018/05/20/19/5741_12yBwE_d7k9lnm.jpg!r800x0.jpg'),
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
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: _widgetOption.elementAt(_selectedIndex),
                  ),
                  Flexible(
                    child: FadeInImage.assetNetwork(
                        placeholder:'assets/1.jpg',
                        image:'https://truth.bahamut.com.tw/s01/202101/5686a83fc52f34a606e2d5df43fe58f8.JPG'),
                  ),
                  Flexible(
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                        'https://titangene.github.io/images/cover/flutter.jpg'),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 100,
                    child: RaisedButton(
                      onPressed: () {
                        Scaffold.of(context).removeCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(_snackBar1);
                      },
                      child: Text('First Button'),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}