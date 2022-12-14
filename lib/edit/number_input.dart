import 'package:benben/models/note_data.dart';
import 'package:flutter/material.dart';

typedef InputUpdate = Function(String, double);

class NumberInput extends StatefulWidget {
  const NumberInput(
      {Key? key, required this.inputUpdate, required this.numberNote})
      : super(key: key);

  final SubNote numberNote;
  final InputUpdate inputUpdate;

  @override
  State<StatefulWidget> createState() {
    return NumberInputState();
  }
}

class NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: (widget.numberNote is Income)
            ? (widget.numberNote as Income).income.toString()
            : (widget.numberNote as Outcome).outcome.toString());
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_controller.value.text == "0.0") {
        _controller.text = "";
      } else if (_controller.value.text.isEmpty) {
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
              value: (widget.numberNote is Income)
                  ? (widget.numberNote as Income).title
                  : (widget.numberNote as Outcome).title,
              items: const [
                DropdownMenuItem(
                    child: InsertTypeItem(title: "宠物", iconData: Icons.pets),
                    value: "宠物"),
                DropdownMenuItem(
                    child: InsertTypeItem(title: "房租", iconData: Icons.house),
                    value: "房租"),
                DropdownMenuItem(
                    child:
                        InsertTypeItem(title: "房贷", iconData: Icons.add_home),
                    value: "房贷"),
                DropdownMenuItem(
                    child: InsertTypeItem(
                        title: "加油", iconData: Icons.local_gas_station),
                    value: "加油"),
                DropdownMenuItem(
                    child: InsertTypeItem(
                        title: "购物", iconData: Icons.local_grocery_store),
                    value: "购物"),
                DropdownMenuItem(
                    child:
                        InsertTypeItem(title: "餐饮", iconData: Icons.set_meal),
                    value: "餐饮"),
                DropdownMenuItem(
                    child: InsertTypeItem(title: "饮料", iconData: Icons.coffee),
                    value: "饮料"),
                DropdownMenuItem(
                    child:
                        InsertTypeItem(title: "车辆", iconData: Icons.car_repair),
                    value: "车辆"),
                DropdownMenuItem(
                    child: InsertTypeItem(
                        title: "停车", iconData: Icons.local_parking),
                    value: "停车"),
                DropdownMenuItem(
                    child: InsertTypeItem(title: "住宿", iconData: Icons.hotel),
                    value: "住宿"),
                DropdownMenuItem(
                    child: InsertTypeItem(
                        title: "通勤", iconData: Icons.directions_bus),
                    value: "通勤"),
                DropdownMenuItem(
                    child: InsertTypeItem(
                        title: "母婴", iconData: Icons.child_friendly),
                    value: "母婴"),
                DropdownMenuItem(
                    child: InsertTypeItem(title: "感情", iconData: Icons.people),
                    value: "感情"),
                DropdownMenuItem(
                    child: InsertTypeItem(
                        title: "自定义", iconData: Icons.dashboard_customize),
                    value: "自定义"),
              ],
              onChanged: (item) {
                if (item == "custom") {
                  return;
                }

                setState(() {
                  if (widget.numberNote is Income) {
                    Income incomeNote = widget.numberNote as Income;
                    incomeNote.title = item as String;
                  } else {
                    Outcome outcomeNote = widget.numberNote as Outcome;
                    outcomeNote.title = item as String;
                  }
                });
              },
            )),
        const SizedBox(
          width: 40,
        ),
        Container(
            alignment: Alignment.center,
            width: 80,
            height: 48,
            child: TextFormField(
              focusNode: _focusNode,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                if (widget.numberNote is Income) {
                  Income incomeNote = widget.numberNote as Income;
                  incomeNote.income = double.parse(value);
                } else {
                  Outcome outcomeNote = widget.numberNote as Outcome;
                  outcomeNote.outcome = double.parse(value);
                }
              },
              textAlign: TextAlign.center,
              controller: _controller,
            )),
        const Text("元")
      ],
    );
  }
}

class InsertTypeItem extends StatelessWidget {
  final String title;
  final IconData iconData;

  const InsertTypeItem({Key? key, required this.title, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(iconData), const SizedBox(width: 16), Text(title)],
    );
  }
}
