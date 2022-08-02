import 'dart:developer';

import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<StatefulWidget> createState() {
    return TextInputState();
  }

}

class TextInputState extends State<TextInput> {

  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    if(widget.text.isNotEmpty) {
      _controller.text = widget.text;
    }

    _focusNode.addListener(() {
      if(_controller.text == "请在这里输入内容..."){
        _controller.text = "";
      } else if(_controller.text.isEmpty) {
        _controller.text = "请在这里输入内容...";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: EditableText(
          controller: _controller,
          focusNode: _focusNode,
          maxLines: null,
          style: const TextStyle(color: Colors.brown, fontSize: 16, letterSpacing: 1.5, height: 1.4),
          cursorColor: Colors.black,
          backgroundCursorColor: Colors.black26),
    );
  }

}