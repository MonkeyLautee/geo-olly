import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? iconColor;
  const MyAppBar(this.title,{
    this.actions,
    this.leading,
    this.iconColor,
    super.key,
  });
  @override
  Widget build(BuildContext context)=>AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).colorScheme.primary,
    iconTheme: IconThemeData(color:iconColor),
    title: title,
    actions: actions,
    leading: leading,
  );
}