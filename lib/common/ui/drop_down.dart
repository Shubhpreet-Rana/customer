import 'package:app/common/colors.dart';
import 'package:app/common/methods/call_back.dart';
import 'package:app/common/styles/styles.dart';
import 'package:flutter/material.dart';

import '../methods/common.dart';

class AppDropdown extends StatefulWidget {
  final Color? bgColor;
  final List<String>? items;
  final String? selectedItem;
  final StringCallback? onChange;

  const AppDropdown({Key? key, this.bgColor, this.items, this.selectedItem, this.onChange}) : super(key: key);

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? selectedItem;

  @override
  void initState() {
    selectedItem = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 55.0,
      width: CommonMethods.deviceWidth(),
      decoration: BoxDecoration(color: Colours.lightGray.code, borderRadius: BorderRadius.circular(10.0)),
      child: DropdownButtonHideUnderline(
          child: DropdownButton(
        value: selectedItem ?? widget.items![0],
        items: widget.items!.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? val) {
          selectedItem = val;
          if(widget.onChange!=null) {
            widget.onChange!(selectedItem!);
          }
          setState(() {});
        },
        style: AppStyles.blackText,
        icon: const Icon(Icons.keyboard_arrow_down),
      ) // your Dropdown Widget here
          ),
    );
  }
}
