import 'package:flutter/material.dart';

class NumberInput extends StatelessWidget {
  const NumberInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 120,
          height: 48,
          child: EditableText(
              controller: TextEditingController(),
              focusNode: FocusNode(),
              style: const TextStyle(fontSize: 20,color: Colors.brown),
              cursorColor: Colors.black12,
              backgroundCursorColor: Colors.greenAccent
          ),
        ),
        const SizedBox(
          width: 40,
        ),
        Container(
          alignment: Alignment.center,
          width: 120,
          height: 48,
          child: EditableText(
              controller: TextEditingController(),
              focusNode: FocusNode(),
              style: const TextStyle(fontSize: 20,color: Colors.brown),
              cursorColor: Colors.black12,
              backgroundCursorColor: Colors.greenAccent
          ),
        ),
      ],
    );
  }

}