
import 'package:flutter/material.dart';

import '../colors.dart';
import '../methods/call_back.dart';
import '../methods/common.dart';
import '../styles/styles.dart';

class AppDropdown extends StatefulWidget {
  final Color? bgColor;
  final List<String>? items;
  final String? selectedItem;
  final StringCallback? onChange;
  final double height;

  const AppDropdown({Key? key, this.bgColor, this.items, this.selectedItem, this.onChange, this.height = 55.0}) : super(key: key);

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
      height: widget.height,
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
          if (widget.onChange != null) {
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
