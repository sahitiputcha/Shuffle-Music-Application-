import 'dart:convert';
import 'dart:io';
import 'package:e_commerce/Song.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'loading.dart';
import 'profilepage.dart';
import 'signuppage.dart';
import 'package:e_commerce/Mainpage.dart';
import 'colors.dart';
import 'main.dart';
import 'Mainpage.dart';
import 'Song.dart';
import 'signuppage.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(MaterialApp(
    home: Mainpage(),
  ));
}


class Mainpage extends StatefulWidget {


  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwdController = TextEditingController();
  Future login() async{
    http.Response response = await http.post(Uri.parse('http://192.168.0.102/win.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:json.encode({

          "Email": emailController.text,
          "Password": passwdController.text,

        }));
    print("success");
    print(response.statusCode);
  }
  bool _autoValidate = false;
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: scaffoldbgcolor,

      body: SingleChildScrollView(
        child: Padding(

          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Column(
                children: [
                  SizedBox(height:80,),
                ],
              ),
              SizedBox(height:30,),
//title fields
              Center(
                child: Text('Login', style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold,
                    color: darkfontcolor
                ),),
              ),
              SizedBox(height: 5,),
              Center(
                child: Text('Welcome Back', style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),),
              ),
              SizedBox(height:80,),


              Form(
                key: _formKey,
                child: Column(
                  children:<Widget> [
//email text field
                    Container(


                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty ){
                            return "*Required";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 30),
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email',fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),

                          filled: true,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,color: Colors.black
                          ),
                        ),
                        controller: emailController,
                        cursorColor: Colors.black,



                      ),



                    ),
                    SizedBox(height: 30),
//password text field
                    Container(
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "*Required";
                          }
                          if(value.length <6){
                            return "this field requires atleast 6 characters";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 30),
                          prefixIcon: Icon(Icons.password_outlined),
                          hintText: 'Password',fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          filled: true,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,color: Colors.black
                          ),
                        ),
                        cursorColor: Colors.black,
                        controller: passwdController,

                      ),



                    ),
                    SizedBox(height: 80),
                    Column(
                      children: [
                        Center(
                          child: MaterialButton(

                            onPressed: () async{
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  _autoValidate = true;
                                }
                                login();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Mainpagee()));
                              });
                            },
                            child: Text("Login",style: TextStyle(fontSize: 20),),
                            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                            color: Colors.white70,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Signuppage()));
                            },
                            child: Text(" Don't Have an account? ",
                              style: TextStyle(
                                  color: darkfontcolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold

                              ),

                            ),
                          ),

                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );






  }
}
