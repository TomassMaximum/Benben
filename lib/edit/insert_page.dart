import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:benben/edit/number_input.dart';
import 'package:benben/edit/text_input.dart';
import 'package:benben/models/note_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return InsertPageState();
  }
}

class InsertPageState extends State<InsertPage> {

  List<SubNote> subNotes = <SubNote>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("写条条"),
        leading: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close, color: Colors.white,)
        ),
        actions: [
          TextButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());

                // TODO 更改时间需要变更
                NoteData _noteData = NoteData(
                    DateTime.now().millisecondsSinceEpoch,
                    DateTime.now().millisecondsSinceEpoch,
                    subNotes,
                    0
                );
                Navigator.of(context).pop(_noteData);
              },
              child: const Icon(Icons.check,color: Colors.white,))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: const Color(0xfffedbd0),
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
          child: ListView(
            key: UniqueKey(),
            children: _getListItems(),
          ),
        ),
      ),
    );
  }

  List<Widget> _getListItems() {
    List<Widget> items = <Widget>[];
    for(SubNote subNote in subNotes) {
      if(subNote is Outcome) {
        items.add(NumberInput(
          inputUpdate: (String title, double value) {
            subNote.title = title;
            subNote.outcome = value;
          })
        );
      } else if(subNote is Income) {
        items.add(NumberInput(
            inputUpdate: (String title, double value) {
              subNote.title = title;
              subNote.income = value;
            })
        );
      } else if(subNote is ImageNote) {
        items.add(
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              padding: const EdgeInsets.all(8),
              child: Image.file(File(subNote.url))
            )
        );
      } else if(subNote is TextNote) {
        items.add(
            TextInput(
              text: subNote.text,
              textUpdate: (String text) {
                subNote.text = text;
              }
            )
        );
      }
    }
    items.add(const Divider());
    items.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          _getTab("支出", Icons.wallet, () {
            setState(() {
              Outcome outcome = Outcome("支出", 15, subNotes.length);
              subNotes.add(outcome);
            });
          }),
          _getTab("收入", Icons.money, () {
            setState(() {
              Income income = Income("title", 200, subNotes.length);
              subNotes.add(income);
            });
          }),
          _getTab("图片", Icons.add_a_photo, () async {
            final ImagePicker _picker = ImagePicker();
            final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
            if(file != null) {
              setState(() {
                ImageNote imageNote = ImageNote(file.path, subNotes.length);
                subNotes.add(imageNote);
              });
            }
          }),
          _getTab("文字", Icons.add_comment, () {
            setState(() {
              TextNote textNote = TextNote("请在这里输入内容...", subNotes.length);
              subNotes.add(textNote);
            });
          })
        ]
    ));

    return items;
  }

  Widget _getTab(String title, IconData iconData, VoidCallback callback) {
    return Column(
        children: [
          TextButton(
            onPressed: callback,
            child: Icon(iconData, size: 28)
          ),
          Text(title)
        ]
    );
  }

}
