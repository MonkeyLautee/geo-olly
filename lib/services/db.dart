import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map?> httpGet(String url) async {
  http.Response res = await http.get(Uri.parse(url));
  if(res.statusCode >= 200 && res.statusCode < 300){
    return json.decode(res.body);
  } else {
    throw Exception('Failed to perform GET request in "$url". Status code ${res.statusCode}.');
  }
}

class DB {

  // This is here because this is just a test app
  static const String api_key = '4ae172eec406442254831e941a1a7e22';
  static const String api_url = 'https://api.openweathermap.org/data/2.5/weather';

  static Future<Map> getWeatherFromCoords({required double lat, required double lon})async{
    Map? res = await httpGet('$api_url?lat=$lat&lon=$lon&appid=$api_key');
    if(res==null) throw 'Null returned';
    return res;
  }
  
  static Map? currentUser;
  
  static void login(String email, String password){
    List users = Hive.box('users').values.toList();
    int? index;
    for(int i = 0; i < users.length; i++){
      if((users[i]['email']==email) && (users[i]['password'] == password)){
        index = i;
      }
    }
    if(index==null)throw 'User does not exists';
    int userID = Hive.box('users').keys.toList()[index];
    Map userMap = Hive.box('users').get(userID);
    currentUser = {
      'id': userID,
      ...userMap,
    };
  }

  static Future<void> signUp(String email, String password)async{
    Hive.box('users').values.toList().forEach((user){
      if(user['email']==email)throw 'User already exists';
    });
    Map userMap = {
      'email': email,
      'password': password,
      'weathers': [],
    };
    int userID = await Hive.box('users').add(userMap);
    currentUser = {
      'id': userID,
      ...userMap,
    };
  }

  static Future<void> logOut()async{
    currentUser = null;
  }

  static Future<void> deleteUser(String password)async{
    int userID = currentUser!['id'];
    Map theUser = Hive.box('users').get(userID)!;
    if(theUser[password] == password){
      await Hive.box('users').delete(userID);
      logOut();
    } else {
      throw 'Incorrect password';
    }
  }

  static Future<void> saveWeather(Map weather)async{
    int userID = currentUser!['id'];
    Map user = Hive.box('users').get(userID);
    List list = [...user['weathers']];
    list.add({...weather});
    await Hive.box('users').put(userID,{
      'email': user['email'],
      'password': user['password'],
      'weathers': list,
    });
  }

  static Future<void> removeWeather(int weatherIndex)async{
    int userID = currentUser!['id'];
    Map user = Hive.box('users').get(userID);
    List list = [...user['weathers']];
    list.removeAt(weatherIndex);
    await Hive.box('users').put(userID,{
      'email': user['email'],
      'password': user['password'],
      'weathers': list,
    });
  }

  static Future<void> clearSavedWeathers()async{
    int userID = currentUser!['id'];
    Map user = Hive.box('users').get(userID);
    await Hive.box('users').put(userID,{
      'email': user['email'],
      'password': user['password'],
      'weathers': [],
    });
  }

  static Future<List> getUserWeathers()async{
    Map user = Hive.box('users').get(currentUser!['id']);
    return user['weathers'] as List;
  }

}