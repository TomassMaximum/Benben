import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {

  final String text;
  final IconData iconData;
  final Widget? newPage;

  const SettingsItem({Key? key, required this.text, required this.iconData, this.newPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if(newPage == null) {
          return;
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => newPage!));
      },
      child: RichText(
        text: TextSpan(
            children: [
              WidgetSpan(child: Icon(iconData, color: Colors.white, size: 20,)),
              const WidgetSpan(child: SizedBox(width: 12)),
              TextSpan(text: text, style: const TextStyle(fontSize: 16, ))
            ]
        ),
      ),
    );
  }

}