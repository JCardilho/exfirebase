import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'widgets/widget_text_custom.dart';
import 'widgets/widgetsButton.dart';
import 'widgets/widgetsInput.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pwd = TextEditingController();
  String _autorized="NOT";
  String _msg = "";
  late FirebaseAuth _auth ;
  Color _colors=Colors.red as Color;
  @override
  Widget build(BuildContext context) {
    _initFirebase();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextosCustom("Authenticate with Firebase", 16, Colors.white),
        backgroundColor: Colors.redAccent,
      ),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      children: [
        InputTextos("Input your email", "Email", controller: _email),
        InputTextos("Input your password", "Password", controller: _pwd),
        Botoes("Authenticate", onPressed: _authenticate),
        Botoes("Create user", onPressed: _createUser),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextosCustom(_autorized, 18, _colors as Color)
          ],
        ),
        TextosCustom(_msg, 12, _colors as Color)

      ],
    );
  }

  Future <void> _initFirebase() async{
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;

  }

  Future <void> _authenticate() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email.text.toString(),
          password: _pwd.text.toString()
      );
      _autorized = "Yes, user is conected";
      _colors = Colors.blueAccent as Color;
      _msg = userCredential.toString();
    }catch(e){
      _autorized =  "Nop, email or password incorrect";
      _colors = Colors.redAccent as Color;
      _msg = e.toString();
    }
    setState((){

    });
  }

  Future <void> _createUser() async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: _email.text,
      password: _pwd.text,
    );
    print('Account has created: ${userCredential.user?.email}');
  }cath (e){
    print('Error. Please try again: $e');
  }
}
