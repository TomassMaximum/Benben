import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:benben/edit/image_input.dart';
import 'package:benben/edit/number_input.dart';
import 'package:benben/edit/text_input.dart';
import 'package:benben/models/note_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../elements/date_text.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({Key? key, required this.noteData}) : super(key: key);

  final NoteData noteData;

  @override
  State<StatefulWidget> createState() {
    return InsertPageState();
  }
}

class InsertPageState extends State<InsertPage> {
  late ScrollController _scrollController;
  late StreamController<NoteData> _streamController;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(keepScrollOffset: true);
    _streamController = StreamController(onListen: () => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("写条条"),
        leading: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
            )),
        actions: [
          TextButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());

                widget.noteData.modifiedAt =
                    DateTime.now().millisecondsSinceEpoch;

                // TODO 更改时间需要变更
                Navigator.of(context).pop(widget.noteData);
              },
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: const Color(0xfffedbd0),
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: StreamBuilder<NoteData>(
              stream: _streamController.stream,
              initialData: widget.noteData,
              builder: (context, noteDataSnap) {
                NoteData _noteData = noteDataSnap.data!;
                return AnimatedList(
                  controller: _scrollController,
                  initialItemCount: _noteData.subNotes.length + 3,
                  key: _listKey,
                  itemBuilder: (context, index, animation) {
                    log("index: ${index.toString()}");
                    return _getListItems(_noteData)[index];
                  },
                );
              }),
        ),
      ),
    );
  }

  List<Widget> _getListItems(NoteData noteData) {
    List<Widget> items = <Widget>[];

    // 默认日期为当前
    items.add(TextButton(
        child: DateText(
            dateTime: DateTime.fromMillisecondsSinceEpoch(noteData.dateTime)),
        onPressed: () async {
          await AwesomeDialog(
              context: context,
              dialogType: DialogType.NO_HEADER,
              body: SfDateRangePicker(
                onSelectionChanged: _onDateSelectionChanged,
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
              )).show();
        }));

    for (SubNote subNote in noteData.subNotes) {
      if (subNote is Outcome) {
        items.add(GestureDetector(
          onLongPress: () {
            noteData.subNotes.remove(subNote);
            _listKey.currentState!
                .removeItem(0, (context, animation) => Container());
          },
          child: NumberInput(
              numberNote: subNote,
              inputUpdate: (String title, double value) {
                subNote.title = title;
                subNote.outcome = value;
              }),
        ));
      } else if (subNote is Income) {
        items.add(GestureDetector(
          onLongPress: () {
            noteData.subNotes.remove(subNote);
            _listKey.currentState!
                .removeItem(0, (context, animation) => Container());
          },
          child: NumberInput(
              numberNote: subNote,
              inputUpdate: (String title, double value) {
                subNote.title = title;
                subNote.income = value;
              }),
        ));
      } else if (subNote is ImageNote) {
        items.add(GestureDetector(
            onLongPress: () {
              noteData.subNotes.remove(subNote);
              _listKey.currentState!
                  .removeItem(0, (context, animation) => Container());
            },
            child: ImageInput(imageData: subNote.imageData)));
      } else if (subNote is TextNote) {
        items.add(GestureDetector(
          onLongPress: () {
            noteData.subNotes.remove(subNote);
            _listKey.currentState!
                .removeItem(0, (context, animation) => Container());
          },
          child: TextInput(
              text: subNote.text,
              textUpdate: (String text) {
                subNote.text = text;
              }),
        ));
      }
    }
    items.add(const Divider());
    items.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _getTab("支出", Icons.wallet, () {
        Outcome outcome = Outcome("餐饮", 0, noteData.subNotes.length);
        noteData.subNotes.add(outcome);

        _listKey.currentState!.insertItem(0);
        // _streamController.add(noteData);
      }),
      _getTab("收入", Icons.money, () {
        Income income = Income("餐饮", 0, noteData.subNotes.length);
        noteData.subNotes.add(income);

        _listKey.currentState!.insertItem(0);
        // _streamController.add(noteData);
      }),
      _getTab("图片", Icons.add_a_photo, () async {
        final ImagePicker _picker = ImagePicker();
        final XFile? file =
            await _picker.pickImage(source: ImageSource.gallery);
        if (file != null) {
          Uint8List bytes = await file.readAsBytes();
          var result = await FlutterImageCompress.compressWithList(
            bytes,
            minHeight: 1920,
            minWidth: 1080,
            quality: 88,
          );

          String base64Image = base64Encode(result);
          ImageNote imageNote =
              ImageNote("", base64Image, noteData.subNotes.length);
          noteData.subNotes.add(imageNote);

          _listKey.currentState!.insertItem(0);
          // _streamController.add(noteData);
        }
      }),
      _getTab("文字", Icons.add_comment, () {
        TextNote textNote = TextNote("请在这里输入内容...", noteData.subNotes.length);
        noteData.subNotes.add(textNote);

        _listKey.currentState!.insertItem(0);
        // _streamController.add(noteData);
      })
    ]));

    return items;
  }

  _onDateSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    Navigator.of(context).pop();
    DateTime _dateTime = args.value as DateTime;
    setState(() {
      widget.noteData.dateTime = _dateTime.millisecondsSinceEpoch;
    });
  }

  Widget _getTab(String title, IconData iconData, VoidCallback callback) {
    return Column(children: [
      TextButton(onPressed: callback, child: Icon(iconData, size: 28)),
      Text(title)
    ]);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
