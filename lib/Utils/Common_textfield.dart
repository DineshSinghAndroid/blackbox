import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonTextFieldWidget extends StatelessWidget {
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final Color? bgColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hint;
  final Iterable<String>? autofillHints;
  final TextEditingController? controller;
  final bool? readOnly;
  final int? value = 0;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final VoidCallback? onTap;

  const CommonTextFieldWidget({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.bgColor,
    this.validator,
    this.suffix,
    this.autofillHints,
    this.prefix,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 18 , right: 18),
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly!,
        controller: controller,
        obscureText: hint == hint ? obscureText! : false,
        autofillHints: autofillHints,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
            hintText: hint,
            focusColor: Colors.grey,
            hintStyle:
            TextStyle(color: Colors.black54, fontSize: 16),
            filled: true,
            fillColor: Colors.white30.withOpacity(.02),
            contentPadding: EdgeInsets.symmetric(horizontal: 12)
                .copyWith(top: maxLines! > 4 ? 18 : 0),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black54.withOpacity(0.5)),
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black54.withOpacity(0.5), width: 3.0),
                borderRadius: BorderRadius.circular(15.0)),
            suffixIcon: suffix,
            prefixIcon: prefix),
      ),
    );
  }
}
