import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final Widget? leading;
  final void Function(String)? onSubmitted;
  const MyTextField(this.controller,{
    this.hint,
    this.leading,
    this.onSubmitted,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 7,
            spreadRadius: 1,
            offset: Offset(2,2),
          ),
        ],
      ),
      child: TextField(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        controller: controller,
        keyboardType: TextInputType.text,
        onSubmitted:onSubmitted,
        maxLines:1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal:12,vertical:0),
          prefixIcon: leading,
          hintText: hint,
          hintStyle: const TextStyle(color:Colors.grey,fontSize:17),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color:Theme.of(context).colorScheme.secondary,width:2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color:Theme.of(context).colorScheme.secondary,width:2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color:Theme.of(context).colorScheme.secondary,width:2.0),
          ),
        ),
      ),
    );
  }
}