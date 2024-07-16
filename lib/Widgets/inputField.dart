import 'package:flutter/material.dart';
import 'package:todoapp/themeData.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final String? Function(String?)? validator;

  const InputField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(
              top: 8,
              bottom: 5,
            ),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  cursorColor: Colors.grey,
                  controller: controller,
                  validator: validator,
                  style: subtitleStyle,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subtitleStyle,
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 0,
                    )),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 0,
                    )),
                  ),
                )),
                widget == null ? Container() : Container(child: widget)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
