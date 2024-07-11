import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/services.dart';
import 'pages/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Hive code
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('users');
  runApp(const GeoOlly());
}

class GeoOlly extends StatelessWidget {
  const GeoOlly({super.key});
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geo Olly',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(242,91,88,1),
        colorScheme: const ColorScheme(
          primary: Color.fromRGBO(242,91,88,1),
          onPrimary: Colors.white,
          secondary: Color.fromRGBO(254,216,33,1),
          onSecondary: Colors.black,
          brightness: Brightness.light,
          error: Colors.red,
          onError: Colors.white,
          surface: Color.fromRGBO(242,242,242,1),
          onSurface: Colors.black,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(242,91,88,0.72),
          selectionColor: Color.fromRGBO(242,91,88,0.21),
          selectionHandleColor: Color.fromRGBO(242,91,88,0.72),
        ),
        textTheme:const TextTheme(
          headlineMedium:TextStyle(
            color:Colors.black,
            fontWeight:FontWeight.bold,
            fontSize:19.0,
          ),
          bodyMedium:TextStyle(
            color:Colors.black,
            fontSize:16.0,
          ),
        ),
      ),
      home: const Wrapper(),
    );
  }
}