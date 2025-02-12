import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lurahku_remake/app/template/color_app.dart';

class KolomInputan extends StatefulWidget {
  final String label;
  final TextStyle labelStyle;
  final RxBool obsecure;
  final String obsecureChar;
  final TextEditingController textEditingC;
  final bool isPassword;
  final bool isNumber;
  final VoidCallback? isPeek;

  KolomInputan({
    super.key,
    required this.label,
    required this.labelStyle,
    RxBool? obsecure,
    this.obsecureChar = '*',
    required this.textEditingC,
    required this.isPassword,
    required this.isNumber,
    this.isPeek,
  }) : obsecure = obsecure ?? false.obs;

  @override
  _KolomInputanState createState() => _KolomInputanState();
}

class _KolomInputanState extends State<KolomInputan> {
  late FocusNode focusNode;
  final RxBool isFocused = false.obs;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: isFocused.value ? primary3 : Colors.transparent,
          child: TextField(
            controller: widget.textEditingC,
            focusNode: focusNode,
            obscureText: widget.obsecure.value,
            obscuringCharacter: widget.obsecureChar,
            keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: widget.labelStyle,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(8),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: widget.isPeek,
                      icon: Icon(widget.obsecure.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                    )
                  : null,
            ),
          ),
        ));
  }
}
