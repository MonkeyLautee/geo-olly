import 'package:flutter/material.dart';
import '../services/helper.dart';
import '../services/db.dart';
import '../widgets/my_text_field.dart';
import '../widgets/my_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

	late final TextEditingController _email;
	late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
		_password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
		_password.dispose();
    super.dispose();
  }

  void _signIn(BuildContext ctx)async{
  	String email = _email.text.trim().toLowerCase();
  	String password = _password.text.trim();
  	if(email.length < 5){
  		alert(ctx, 'Invalid email');
  		return;
  	}
  	if(password.length < 5){
  		alert(ctx, 'Invalid password, it has to be at least 5 characters');
  		return;
  	}
		try {
			DB.login(email,password);
			Navigator.pop(ctx);
		} catch(e) {
			await alert(ctx,'Incorrect credentials');
		}
  }
	void _signUp(BuildContext ctx)async{
		String email = _email.text.trim().toLowerCase();
  	String password = _password.text.trim();
  	if(email.length < 5){
  		alert(ctx, 'Invalid email');
  		return;
  	}
  	if(password.length < 5){
  		alert(ctx, 'Invalid password');
  		return;
  	}
		doLoad(ctx);
		try {
			await DB.signUp(email,password);
			Navigator.pop(ctx);
		} catch(e) {
			print('$e');
			await alert(ctx,'An error happened, user may already exists');
		} finally {
			Navigator.pop(ctx);
		}
	}

	void _logOut(BuildContext ctx)async{
		bool? answer = await confirm(ctx,'Log out?');
		if(answer==true){
			DB.logOut();
			Navigator.pop(ctx);
		}
	}

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
    	backgroundColor:Theme.of(ctx).colorScheme.primary,
      body: SafeArea(
      	child: ListView(
          padding: const EdgeInsets.all(16),
          children: DB.currentUser!=null?[
          	const SizedBox(height: 36),
          	Image.asset('assets/logo.png',height:200),
          	const SizedBox(height: 42),
          	Center(
          		child: MyButton('Log out',()=>_logOut(ctx)),
          	),
          ]:[
          	const SizedBox(height: 36),
          	Image.asset('assets/logo.png',height:200),
          	const SizedBox(height: 36),
          	MyTextField(
          		_email,
							leading: Icon(Icons.email,color:primColor(ctx)),
          		hint: 'Email',
          	),
          	const SizedBox(height: 16),
          	MyTextField(
          		_password,
							leading: Icon(Icons.key,color:primColor(ctx)),
          		hint: 'Password',
          	),
          	const SizedBox(height: 16),
          	MyButton('Sign in',()=>_signIn(ctx),color:Color.fromRGBO(247,151,149,1)),
          	const SizedBox(height: 16),
          	MyButton('Sign up',()=>_signUp(ctx),color:Color.fromRGBO(247,151,149,1)),
          	const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}