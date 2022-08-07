import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/note_data.dart';

enum Menu { mark, share, delete }

typedef OnItemMarked = Function();
typedef OnItemShared = Function();
typedef OnItemDeleted = Function();

class NoteItem extends StatelessWidget {
  const NoteItem({Key? key, required this.note, required this.onItemMarked, required this.onItemShared, required this.onItemDeleted}) : super(key: key);

  final OnItemMarked onItemMarked;
  final OnItemShared onItemShared;
  final OnItemDeleted onItemDeleted;

  final NoteData note;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 254, 234, 230),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
      child: Container(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getNoteWidgets(note),
        ),
      ),
    );
  }

  List<Widget> _getNoteWidgets(NoteData noteData) {
    List<Widget> subNotesList = <Widget>[];
    int timestamp = noteData.createdAt;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    subNotesList.add(SizedBox(
      height: 36,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              child: Text(
                  "${dateTime.month.toString()}月${dateTime.day.toString()}日 ${getWeekday(dateTime.weekday)}")),
          Positioned(
            right: 0,
            child: PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                PopupMenuItem<Menu>(
                    value: Menu.mark,
                    child: RichText(
                        text: const TextSpan(children: [
                      WidgetSpan(
                          child: Icon(
                        Icons.bookmark,
                        size: 16,
                      )),
                      WidgetSpan(child: SizedBox(width: 12)),
                      TextSpan(
                          text: "标记",
                          style: TextStyle(fontSize: 16, color: Colors.black))
                    ]))),
                PopupMenuItem<Menu>(
                    value: Menu.share,
                    child: RichText(
                        text: const TextSpan(children: [
                      WidgetSpan(
                          child: Icon(
                        Icons.share,
                        size: 16,
                      )),
                      WidgetSpan(child: SizedBox(width: 12)),
                      TextSpan(
                          text: "分享",
                          style: TextStyle(fontSize: 16, color: Colors.black))
                    ]))),
                PopupMenuItem<Menu>(
                    value: Menu.delete,
                    child: RichText(
                        text: const TextSpan(children: [
                      WidgetSpan(
                          child: Icon(
                        Icons.delete,
                        size: 16,
                      )),
                      WidgetSpan(child: SizedBox(width: 12)),
                      TextSpan(
                          text: "删除",
                          style: TextStyle(fontSize: 16, color: Colors.black))
                    ])))
              ],
              onSelected: (Menu item) {
                switch(item) {
                  case Menu.mark:
                    // TODO: Handle this case.
                    break;
                  case Menu.share:
                    // TODO: Handle this case.
                    break;
                  case Menu.delete:
                    onItemDeleted();
                    break;
                }
              },
              child: const Icon(Icons.more_horiz),
            ),
          )
        ],
      ),
    ));

    for (SubNote subNote in noteData.subNotes) {
      if (subNote is Income) {
        subNotesList.add(Row(
            children: [Text(subNote.title), Text(subNote.income.toString())]));
      } else if (subNote is Outcome) {
        subNotesList.add(Row(
            children: [Text(subNote.title), Text(subNote.outcome.toString())]));
      } else if (subNote is ImageNote) {
        subNotesList.add(Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            padding: const EdgeInsets.all(8),
            child: Image.memory(base64Decode(subNote.imageData))));
      } else if (subNote is TextNote) {
        subNotesList.add(Text(
          subNote.text,
          style: const TextStyle(
              color: Colors.brown,
              fontSize: 16,
              letterSpacing: 1.5,
              height: 1.4),
        ));
      }
    }

    return subNotesList;
  }

  String getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return "星期一";
      case 2:
        return "星期二";
      case 3:
        return "星期三";
      case 4:
        return "星期四";
      case 5:
        return "星期五";
      case 6:
        return "星期六";
      case 7:
        return "星期日";
      default:
        log("Error! weekday unexpected: ${weekday.toString()}");
        return "N/A";
    }
  }
}
