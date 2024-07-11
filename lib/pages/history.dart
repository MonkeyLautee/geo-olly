import 'package:flutter/material.dart';
import '../services/helper.dart';
import '../services/db.dart';
import '../widgets/my_button.dart';

class History extends StatefulWidget {
  const History({super.key});
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

	List _weathers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      if(DB.currentUser == null){
        await alert(context,'You must sign in to use this page');
        return;
      }
      doLoad(context);
      try {
      	List data = await DB.getUserWeathers();
      	setState(()=>_weathers = data);
      } catch(e) {
      	await alert(context,'An error happened');
      } finally {
      	Navigator.pop(context);
      }
    });
  }

  void _clearSavedWeathers(BuildContext ctx)async{
  	doLoad(ctx);
  	try {
  		await DB.clearSavedWeathers();
  	} catch(e) {
  		await alert(ctx,'An error happened');
  	} finally {
  		Navigator.pop(ctx);
  	}
  }

  void _deleteWeather(BuildContext ctx, int weatherIndex)async{
  	bool? answer = await confirm(ctx,'Remove weather?');
  	if(answer==true){
  		doLoad(ctx);
  		try {
  			await DB.removeWeather(weatherIndex);
  			List data = await DB.getUserWeathers();
      	setState(()=>_weathers = data);
  		} catch(e) {
  			await alert(ctx,'An error happened');
  		} finally {
  			Navigator.pop(ctx);
  		}
  	}
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
    	backgroundColor:Theme.of(ctx).colorScheme.surface,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
        	Text(
        		'History',
        		style: TextStyle(
        			color: primColor(ctx),
        			fontSize: 20,
        			fontWeight: FontWeight.bold,
        		),
        		textAlign: TextAlign.center,
        	),
        	const SizedBox(height: 12),
        	Visibility(
        		visible: _weathers.isEmpty,
        		child: const Text(
        			'No saved weathers yet',
        			style: TextStyle(color: Colors.grey),
        			textAlign: TextAlign.center,
        		),
        	),
        	Column(children:_weathers.asMap().entries.toList().map((item){
						int weatherIndex = item.key;
						Map weather = item.value;
        		return Card(
              elevation: 5.5,
	        		child: ListTile(
	        			leading: const Icon(Icons.wb_cloudy),
	        			title: Text(
                  weather['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
	        			subtitle: Text(weather['time']),
	        			trailing: IconButton(
	        				icon: const Icon(Icons.delete),
	        				onPressed: ()=>_deleteWeather(ctx,weatherIndex),
	        			),
	        		),
	        	);
        	}).toList()),
        	const SizedBox(height: 12),
          Visibility(
            visible: DB.currentUser != null,
            child: Center(child: MyButton('Clear saved weathers',()=>_clearSavedWeathers(ctx))),
          ),
        	const SizedBox(height: 12),
        ],
      ),
    );
  }
}