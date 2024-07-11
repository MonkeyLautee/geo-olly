import 'package:flutter/material.dart';

Color primColor(BuildContext ctx)=>Theme.of(ctx).colorScheme.primary;

Color secColor(BuildContext ctx)=>Theme.of(ctx).colorScheme.secondary;

double screenWidth(BuildContext ctx)=>MediaQuery.of(ctx).size.width;

double screenHeight(BuildContext ctx)=>MediaQuery.of(ctx).size.height;

Future<dynamic?> goTo(BuildContext ctx,Widget p)async=>await Navigator.push(ctx,MaterialPageRoute(builder:(x)=>p));

Future<void> alert(BuildContext context,String message, {bool selectable=false,bool dismissible=true})async{
  await showDialog(
    context:context,
    barrierDismissible: dismissible,
    builder:(context){
      return SimpleDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: selectable?
        SelectableText(message,style:TextStyle(fontSize:17,color:Theme.of(context).colorScheme.onSurface),textAlign:TextAlign.center):
        Text(message,style:TextStyle(fontSize:17,color:Theme.of(context).colorScheme.onSurface),textAlign:TextAlign.center),
        children:[
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              ElevatedButton(
                onPressed:()=>Navigator.pop(context),
                style:ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                ),
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal:32),
                  child: Text('Ok',style:TextStyle(color:Theme.of(context).colorScheme.onPrimary)),
                ),
              ),
            ],
          ),
        ],
      );
    }
  );
}

Future<bool?> confirm(BuildContext context, String question)async{
  bool? answer;
  await showDialog(
    context: context,
    barrierDismissible:true,
    builder: (context){
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(question,style:TextStyle(fontSize:17,color:Theme.of(context).colorScheme.onSurface)),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style:ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:23),
                  child: Text('Yes',style:TextStyle(fontSize:17,color:Theme.of(context).colorScheme.onPrimary)),
                ),
                onPressed: (){
                  answer = true;
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12, width: 12),
              ElevatedButton(
                style:ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:23),
                  child: Text('No',style:TextStyle(fontSize:17,color:Theme.of(context).colorScheme.onPrimary)),
                ),
                onPressed: (){
                  answer = false;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      );
    },
  );
  return answer;
}

Future<String?> prompt(BuildContext context, {String text='', String initialValue='', Widget child=const SizedBox(), int maxCharacters=0, TextInputType type=TextInputType.text, bool obscureText=false, bool dismissible=true})async{
  bool okButtonPressed=false;
  final TextEditingController stringController = TextEditingController();
  await showDialog(
    context:context,
    barrierDismissible:dismissible,
    builder:(context)=>SimpleDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      contentPadding:const EdgeInsets.all(10.0),
      title:text==''?null:Text(text,style:TextStyle(fontSize:17,color:Theme.of(context).colorScheme.onSurface)),
      children:<Widget>[
        TextField(
          style:TextStyle(color:Theme.of(context).colorScheme.onSurface),
          keyboardType:type,
          maxLines:type==TextInputType.multiline?null:1,
          textCapitalization:TextCapitalization.sentences,
          maxLength:maxCharacters==0?null:maxCharacters,
          controller:stringController..text=initialValue,
          autofocus:true,
          obscureText:obscureText,
        ),
        const SizedBox(height: 12, width: 12),
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children:<Widget>[
            ElevatedButton(
              style:ButtonStyle(
                backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:12),
                child: Text('Ok',style:TextStyle(fontSize:16,color:Theme.of(context).colorScheme.onPrimary)),
              ),
              onPressed:(){
                okButtonPressed=true;
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style:ButtonStyle(
                backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:12),
                child: Text('Cancel',style:TextStyle(fontSize:16,color:Theme.of(context).colorScheme.onPrimary)),
              ),
              onPressed:(){
                Navigator.pop(context);
              },
            ),
          ],
        ),
        child,
      ],
    ),
  );
  return okButtonPressed?stringController.text.trim():null;
}

void doLoad(BuildContext context){
  showDialog(
    context: context,
    builder: (context){
      return PopScope(
        canPop: false,
        child: AbsorbPointer(
          absorbing: true,
          child: Center(
            child: Material(
              type:MaterialType.transparency,
              child:CircularProgressIndicator(color:Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      );
    }
  );
}