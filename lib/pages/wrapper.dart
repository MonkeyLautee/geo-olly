import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../services/helper.dart';
import '../widgets/my_app_bar.dart';
import 'home.dart';
import 'history.dart';
import 'about.dart';
import 'auth_page.dart';

class Wrapper extends StatefulWidget{
  const Wrapper({super.key});
  @override
  State<Wrapper> createState()=>_WrapperState();
}

class _WrapperState extends State<Wrapper>{
  
  int _pageIndex=0;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: MyAppBar(
          Image.asset('assets/logo.png',height:40),
          actions: [
            InkWell(
              onTap: ()=>goTo(context,const AuthPage()),
              child: const Row(
                children: [
                  Text(
                    'My account',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width:7),
                  Icon(Icons.person, color:Colors.white),
                  SizedBox(width:7),
                ],
              ),
            ),
          ]
        ),
      ),
      body:[const Home(),const History(),const About()][_pageIndex],
      bottomNavigationBar:CurvedNavigationBar(
        color: primColor(context),
        backgroundColor: Color.fromRGBO(247,151,149,1),
        buttonBackgroundColor: Color.fromRGBO(247,151,149,1),
        items: [
          Transform(
            transform: Matrix4.translationValues(0,_pageIndex==0?0:16,0),
            child:Column(
              children:[
                const Icon(Icons.home,size:30,color:Colors.white),
                Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _pageIndex==0?10:12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            )
          ),
          Transform(
            transform: Matrix4.translationValues(0,_pageIndex==1?0:16,0),
            child:Column(
              children:[
                const Icon(Icons.history,size:30,color:Colors.white),
                Text(
                  'History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _pageIndex==1?10:12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            )
          ),
          Transform(
            transform: Matrix4.translationValues(0,_pageIndex==2?0:16,0),
            child:Column(
              children:[
                const Icon(Icons.info,size:30,color:Colors.white),
                Text(
                  'About',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _pageIndex==2?10:12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            )
          ),
        ],
        onTap: (index) {
          if(_pageIndex != index)setState(()=>_pageIndex = index);
        },
      ),
    );
  }
}