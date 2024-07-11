import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/helper.dart';
import '../widgets/my_button.dart';

class About extends StatelessWidget {
  const About({super.key});
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
    	backgroundColor:Theme.of(ctx).colorScheme.surface,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
        	Text(
            'About the app',
            style: TextStyle(
              color: primColor(ctx),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text('This app shows the weather of your current location'),
          const SizedBox(height: 12),
          const Text('You can save the weather and time in your weather history, by creating a user.'),
          const SizedBox(height: 12),
          Center(
            child: MyButton('More about the developer',()=>launchUrl(Uri.parse('https://monkey-lautee.web.app'))),
          ),
          const SizedBox(height: 12),
          Center(
            child: Image.asset('assets/logo.png'),
          ),
        ],
      ),
    );
  }
}