import 'dart:io';

import 'package:benben/edit/number_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InsertPage extends StatelessWidget {
  const InsertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("写小纸条"),
        leading: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close, color: Colors.white,)
        ),
        actions: [
          TextButton(onPressed: () {}, child: const Icon(Icons.check,color: Colors.white,))
        ],
      ),
      body: Container(
        color: const Color(0xfffedbd0),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
        child: Column(
          children: [
            const NumberInput(),
            TextButton(
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();
                  final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
                },
                child: const Icon(Icons.add_a_photo)
            )
          ],
        ),
      ),
    );
  }
}

