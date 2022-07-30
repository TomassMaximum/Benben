import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 254, 234, 230),
      elevation: 2,

      margin: const EdgeInsets.only(left: 12, right: 12,top: 6, bottom: 6),
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateTime.now().toString()),
                const TextButton(
                  onPressed: null,
                  child: Icon(Icons.more_horiz),

                )
              ],
            ),
            const Text("开销：121"),
            const Text("收入：2"),
            const Text("    今天开始继续写小本本app，希望可以坚持下去。这是一个简洁得不要不要的记账app，即将带我向财富自由进发。",
              style: TextStyle(decoration: TextDecoration.underline),

            )
          ],
        ),
      ),

    );
  }

}