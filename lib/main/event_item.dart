import 'dart:developer';

import 'package:flutter/material.dart';

enum Menu { mark, share, delete }

class EventItem extends StatelessWidget {
  const EventItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 254, 234, 230),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.only(left: 12, right: 12,top: 6, bottom: 6),
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 36,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                      child: Text("${DateTime.now().month.toString()}月${DateTime.now().day.toString()}日 ${getWeekday(DateTime.now().weekday)}")
                  ),
                  Positioned(
                    right: 0,
                    child: PopupMenuButton(
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                        PopupMenuItem<Menu>(
                            value: Menu.mark,
                            child: RichText(text: const TextSpan(children: [
                              WidgetSpan(child: Icon(Icons.bookmark, size: 16,)),
                              WidgetSpan(child: SizedBox(width: 12)),
                              TextSpan(text: "标记", style: TextStyle(fontSize: 16, color: Colors.black))
                            ]))
                        ),
                        PopupMenuItem<Menu>(value: Menu.share, child: RichText(text: const TextSpan(children: [
                          WidgetSpan(child: Icon(Icons.share, size: 16,)),
                          WidgetSpan(child: SizedBox(width: 12)),
                          TextSpan(text: "分享", style: TextStyle(fontSize: 16, color: Colors.black))
                        ]))),
                        PopupMenuItem<Menu>(value: Menu.delete, child: RichText(text: const TextSpan(children: [
                          WidgetSpan(child: Icon(Icons.delete, size: 16,)),
                          WidgetSpan(child: SizedBox(width: 12)),
                          TextSpan(text: "删除", style: TextStyle(fontSize: 16, color: Colors.black))
                        ])))
                      ],
                      onSelected: (Menu item) {

                      },
                      child: const Icon(Icons.more_horiz),
                    ),
                  )
                ],
              ),
            ),
            const Text("开销：121"),
            const Text("收入：2"),
            const Text("    今天开始继续写小本本app，希望可以坚持下去。\n    这是一个简洁得不要不要的记账app，即将带我向财富自由进发。",
              style: TextStyle(fontSize: 16, letterSpacing: 1.5, height: 1.5),

            )
          ],
        ),
      ),

    );
  }

  String getWeekday(int weekday) {
    switch(weekday) {
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