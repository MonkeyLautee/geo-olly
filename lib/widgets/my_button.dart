import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const MyButton(this.text,this.onTap,{
    this.color,
    super.key
  });
  @override
  Widget build(BuildContext context)=>ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color??Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
        side: BorderSide.none,
      ),
    ),
    onPressed: onTap,
    child: Text(text,style:const TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:17)),
  );
}