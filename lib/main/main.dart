import 'package:benben/about_app/about_app_page.dart';
import 'package:benben/about_author/about_author_page.dart';
import 'package:benben/database/note_database.dart';
import 'package:benben/main/note_item.dart';
import 'package:benben/edit/insert_page.dart';
import 'package:benben/models/note_data.dart';
import 'package:benben/settings_notification/notification_page.dart';
import 'package:benben/main/settings_item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '小本本',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: '小本本'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NoteData> _notes = <NoteData>[];
  final NoteDatabase _database = NoteDatabase();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _queryNotes();
  }

  _queryNotes() async {
    _notes = await _database.queryNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Container(
          margin: const EdgeInsets.only(right: 100),
          padding: const EdgeInsets.only(top: 80),
          constraints: const BoxConstraints.expand(),
          color: Colors.brown,
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                      backgroundColor: Color(0xfffedbd0),
                      child: Text("Hola"),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("璃月的小龟",
                            style: TextStyle(
                                color: Color(0xfffedbd0), fontSize: 16)),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "id: 1588965",
                          style:
                              TextStyle(color: Color(0xfffedbd0), fontSize: 8),
                        )
                      ])
                ]),
                const SizedBox(height: 160),
                const SettingsItem(
                    text: "通知提醒",
                    iconData: Icons.notifications,
                    newPage: NotificationPage()),
                const Divider(color: Color(0xfffedbd0)),
                const SettingsItem(
                    text: "关于作者",
                    iconData: Icons.face,
                    newPage: AboutAuthorPage()),
                const Divider(color: Color(0xfffedbd0)),
                const SettingsItem(
                    text: "关于APP",
                    iconData: Icons.info,
                    newPage: AboutAppPage()),
                const Divider(color: Color(0xfffedbd0)),
                TextButton(
                  onPressed: () {},
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 20,
                        )),
                        WidgetSpan(child: SizedBox(width: 12)),
                        TextSpan(text: "登出账号", style: TextStyle(fontSize: 16))
                      ]),
                    ),
                  ),
                ),
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
            key: UniqueKey(),
            children: _getNotesList(_notes),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _newNote,
        tooltip: '新增条条',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _getNotesList(List<NoteData> notes) {
    List<Widget> noteWidgets = <Widget>[];
    noteWidgets.add(const SizedBox(height: 6));
    for (NoteData note in notes) {
      noteWidgets.add(NoteItem(
          note: note,
          onItemMarked: () {},
          onItemShared: () {},
          onItemDeleted: () async {
            await _database.deleteNote(note.id);
            _queryNotes();
          }));
    }
    return noteWidgets;
  }

  void _newNote() async {
    NoteData _noteData = NoteData(
        0,
        DateTime.now().millisecondsSinceEpoch,
        DateTime.now().millisecondsSinceEpoch,
        DateTime.now().millisecondsSinceEpoch,
        <SubNote>[],
        0);

    final result = await Navigator.push(context, _createRoute(_noteData));
    if (result != null) {
      await _database.insertNote(result);
      _notes = await _database.queryNotes();
      setState(() {});
    }
  }

  Route _createRoute(NoteData noteData) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          InsertPage(noteData: noteData),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
