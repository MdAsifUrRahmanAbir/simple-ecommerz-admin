import 'package:flutter/material.dart';

class PasswordTextInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintext;
  final TextInputType? keyboardtype;
  final bool? readonly;
  final Color? color;
  final double focusborderwidth;
  final double enableborderwidth;
  final Color bordercolor;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final int maxline;
  final void Function(String?)? onchanged;

  const PasswordTextInputWidget({
    Key? key,
    required this.controller,
    required this.hintext,
    this.keyboardtype,
    this.readonly = false,
    this.focusborderwidth = 2,
    this.enableborderwidth = 1,
    this.maxline = 1,
    this.color = Colors.blue,
    required this.bordercolor,
    this.suffixIcon,
    this.onTap,
    this.onchanged,
  }) : super(key: key);

  @override
  State<PasswordTextInputWidget> createState() =>
      _PasswordTextInputWidgetState();
}

class _PasswordTextInputWidgetState extends State<PasswordTextInputWidget> {
  bool isvisibility = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            maxLines: widget.maxline,
            controller: widget.controller,
            style: const TextStyle(
              color: Colors.black,
            ),
            readOnly: widget.readonly!,
            keyboardType: widget.keyboardtype,
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Please fill out the field";
              } else {
                return null;
              }
            },
            onChanged: widget.onchanged,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueGrey,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.only(
                  left: 16, right: 10, bottom: 10, top: 20),
              hintText: widget.hintext,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isvisibility = !isvisibility;
                    });
                  },
                  icon: Icon(
                    isvisibility ? Icons.visibility_off : Icons.visibility,
                    color: widget.color,
                    size: 20,
                  )),
            ),
            obscureText: isvisibility,
          ),
        ),
      ],
    );
  }
}
