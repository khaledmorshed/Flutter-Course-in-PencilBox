import 'package:flutter/material.dart';
import 'package:vitual_visiting_card/global/selected_line_list.dart';

class LineItemWidget extends StatefulWidget {
   final String line;
   LineItemWidget(this.line);

  @override
  State<LineItemWidget> createState() => _LineItemWidgetState();
}

class _LineItemWidgetState extends State<LineItemWidget> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.line),
      trailing: Checkbox(
        value: _isChecked,
        onChanged: (value){
          setState((){
            _isChecked = value!;
          });
          value! ? selectedLines.add(widget.line) : selectedLines.remove(widget.line);
        },
      ),
    );
  }
}
