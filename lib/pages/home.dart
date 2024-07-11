import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/helper.dart';
import '../services/db.dart';
import '../widgets/my_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map? _weather;

  Future<List<double>> _getCoords()async{
    // Code from: https://pub.dev/packages/geolocator
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    List<double> coords = [position.latitude,position.longitude];
    return coords;
  }

  Future<Map> _getWeatherFromCoords(List<double> coords)async{
    Map weather = await DB.getWeatherFromCoords(lat: coords[0], lon: coords[1]);
    return weather;
  }

  void _getWeather(BuildContext ctx)async{
    doLoad(ctx);
    try{
      List<double> coords = await _getCoords();
      Map apiData = await _getWeatherFromCoords(coords);
      setState((){
        _weather = {
          'title': apiData['weather'][0]['main'],
          'description': apiData['weather'][0]['description'],
        };
      });
    } catch(e) {
      print('$e');
      await alert(ctx,'An error happened');
    } finally {
      Navigator.pop(ctx);
    }
  }

  void _saveWeather(BuildContext ctx)async{
    if(DB.currentUser == null){
      await alert(ctx,'You must sign in to save weather into your account');
      return;
    }
    bool? answer = await confirm(ctx,'Save current location weather?');
    if(answer == true){
      doLoad(ctx);
      try{
        await DB.saveWeather({
          'title': _weather!['title'],
          'time': (DateTime.now()).toString(),
        });
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
      backgroundColor: Theme.of(ctx).colorScheme.surface,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Home page',
            style: TextStyle(
              color: primColor(ctx),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Center(
            child: MyButton('Get current weather',()=>_getWeather(ctx)),
          ),
          const SizedBox(height: 12),
          _weather != null?Card(
            elevation: 5.5,
            child: ListTile(
              leading: Icon(Icons.wb_cloudy,color:primColor(ctx)),
              title: Text(_weather!['title'],style:TextStyle(fontWeight:FontWeight.bold)),
              subtitle: Text(_weather!['description']),
              trailing: IconButton(
                onPressed: ()=>_saveWeather(ctx),
                icon: Icon(Icons.save,color:primColor(ctx),size:36),
              ),
            ),
          ):Text(
            'No weather to show',
            style: TextStyle(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}