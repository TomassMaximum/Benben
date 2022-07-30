import 'package:benben/AboutAppPage.dart';
import 'package:benben/AboutAuthorPage.dart';
import 'package:benben/EventItem.dart';
import 'package:benben/InsertPage.dart';
import 'package:benben/NotificationPage.dart';
import 'package:benben/SettingsItem.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Benben',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: '小本本'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _incrementCounter() {
    Navigator.push(context, _createRoute());
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Container(
          margin: const EdgeInsets.only(right: 100),
          padding: const EdgeInsets.only(top:80),
          constraints: const BoxConstraints.expand(),
          color: Colors.brown,
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundColor: Color(0xfffedbd0),
                        child: Text("Hola"),
                      ),
                    ),
                    const SizedBox(height: 24,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("璃月的小龟", style: TextStyle(color: Color(0xfffedbd0), fontSize: 16)),
                          SizedBox(height: 8,),
                          Text("id: 1588965", style: TextStyle(color: Color(0xfffedbd0), fontSize: 8),)
                        ]

                )
                  ]
                ),
                const SizedBox(height: 160),
                const SettingsItem(text: "通知提醒", iconData: Icons.notifications, newPage: NotificationPage()),
                const Divider(color: Color(0xfffedbd0)),
                const SettingsItem(text: "关于作者", iconData: Icons.face, newPage: AboutAuthorPage()),
                const Divider(color: Color(0xfffedbd0)),
                const SettingsItem(text: "关于APP", iconData: Icons.info, newPage: AboutAppPage()),
                const Divider(color: Color(0xfffedbd0)),
                TextButton(
                    onPressed: () {},
                    child: const SettingsItem(text: "登出账号", iconData: Icons.logout)),
                const Divider(color: Color(0xfffedbd0)),
              ],
            ),
          )),
      body: Container(
        color: const Color(0xfffedbd0),
        alignment: Alignment.center,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: const [
            SizedBox(height: 6),
            EventItem(),
            EventItem(),
            EventItem()
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const InsertPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
