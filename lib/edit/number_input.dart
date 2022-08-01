import 'dart:developer';

import 'package:flutter/material.dart';

typedef InputUpdate = Function (String, double);

class NumberInput extends StatefulWidget {
  const NumberInput({Key? key, required this.inputUpdate}) : super(key: key);

  final InputUpdate inputUpdate;

  @override
  State<StatefulWidget> createState() {
    return NumberInputState();
  }

}

class NumberInputState extends State<NumberInput> {

  String? _selectedItem = "0";
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: "0");
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if(_controller.value.text == "0") {
        _controller.text = "";
      } else if(_controller.value.text.isEmpty) {
        _controller.text = "0";
      }
    });
  }

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
            child: DropdownButton<String>(
              value: _selectedItem,
              items:
              const [
                DropdownMenuItem(child: InsertTypeItem(title: "宠物", iconData: Icons.pets), value: "0"),
                DropdownMenuItem(child: InsertTypeItem(title: "房租", iconData: Icons.house), value: "1"),
                DropdownMenuItem(child: InsertTypeItem(title: "房贷", iconData: Icons.add_home), value: "2"),
                DropdownMenuItem(child: InsertTypeItem(title: "加油", iconData: Icons.local_gas_station), value: "3"),
                DropdownMenuItem(child: InsertTypeItem(title: "购物", iconData: Icons.local_grocery_store), value: "4"),
                DropdownMenuItem(child: InsertTypeItem(title: "餐饮", iconData: Icons.set_meal), value: "5"),
                DropdownMenuItem(child: InsertTypeItem(title: "饮料", iconData: Icons.coffee), value: "6"),
                DropdownMenuItem(child: InsertTypeItem(title: "车辆", iconData: Icons.car_repair), value: "7"),
                DropdownMenuItem(child: InsertTypeItem(title: "停车", iconData: Icons.local_parking), value: "8"),
                DropdownMenuItem(child: InsertTypeItem(title: "住宿", iconData: Icons.hotel), value: "9"),
                DropdownMenuItem(child: InsertTypeItem(title: "通勤", iconData: Icons.directions_bus), value: "10"),
                DropdownMenuItem(child: InsertTypeItem(title: "母婴", iconData: Icons.child_friendly), value: "11"),
                DropdownMenuItem(child: InsertTypeItem(title: "感情", iconData: Icons.people), value: "12"),
                DropdownMenuItem(child: InsertTypeItem(title: "自定义", iconData: Icons.dashboard_customize), value: "13"),
              ],
              onChanged: (item) {
                if(item == "13") {
                  return;
                }
                widget.inputUpdate(item!, double.parse(_controller.value.text));
                setState(() {
                  _selectedItem = item;
                });
              },
            )
        ),
        const SizedBox(
          width: 40,
        ),
        Container(
            alignment: Alignment.center,
            width: 80,
            height: 48,
            child: TextFormField(
              focusNode: _focusNode,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                log("Edit complete");
                widget.inputUpdate(_selectedItem!, double.parse(value));
              },
              textAlign: TextAlign.center,
              controller: _controller,
            )
        ),
        const Text("元")
      ],
    );
  }
}

class InsertTypeItem extends StatelessWidget {

  final String title;
  final IconData iconData;

  const InsertTypeItem({Key? key, required this.title, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: 16),
        Text(title)
      ],
    );
  }

}