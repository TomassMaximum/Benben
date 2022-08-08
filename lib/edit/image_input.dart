import 'dart:convert';

import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key, required this.imageData}) : super(key: key);

  final String imageData;

  @override
  State<StatefulWidget> createState() {
    return ImageInputState();
  }
}

class ImageInputState extends State<ImageInput>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 16, bottom: 16),
        padding: const EdgeInsets.all(8),
        child: Image.memory(base64Decode(widget.imageData),
            gaplessPlayback: true));
  }

  @override
  bool get wantKeepAlive => true;
}
