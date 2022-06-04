import 'package:flutter/material.dart';
import 'package:wallpaper/data/auth.dart';
import 'package:wallpaper/views/signin.dart';

import '../widgets/widgets.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, password;
  AuthService authService = new AuthService();
  bool _isLoading=false;

  signUp() async{
    if(_formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService.signUpWithEmailandPass(email, password).then((val){
        if(val != null){
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Home()
        ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 11, 31),
      appBar: AppBar(
        backgroundColor: Color(0xff152238),
        title: brandName(),
        elevation: 0.0,
      ),
      body: _isLoading ? Container(
        child: Center(child: CircularProgressIndicator(),),
      ) : Form(
        key:_formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (val){return val!.isEmpty ? "Enter name" : null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(240, 255, 255, 255),
                  focusColor: Color.fromARGB(240, 255, 255, 255),
                  hintText: "Name"
                ),
                onChanged: (val){
                  name = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val){return val!.isEmpty ? "Enter email" : null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(240, 255, 255, 255),
                  focusColor: Color.fromARGB(240, 255, 255, 255),
                  hintText: "Email"
                ),
                onChanged: (val){
                  email = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                obscureText: true,
                validator: (val){return val!.isEmpty ? "Enter password" : null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(240, 255, 255, 255),
                  focusColor: Color.fromARGB(240, 255, 255, 255),
                  hintText: "Password"
                ),
                onChanged: (val){
                  password = val;
                },
              ),
              SizedBox(height: 24,),
              InkWell(
                onTap: (){
                  signUp();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(18)
                  ),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text("Sign Up", style: TextStyle(color: Colors.white))
                ),
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Already have an account? ", style: TextStyle(fontSize: 14, color: Colors.white),),
                InkWell(
                  onTap:(){
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => SignIn()
                      ));
                  },
                  child: Text("Sign In", style: TextStyle(fontSize: 14, color: Colors.white, decoration: TextDecoration.underline),))
              ],),
              SizedBox(height: 80,),
          ],)
        ),
      ),
    );
  }
}