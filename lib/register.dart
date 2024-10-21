import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase1/Login.dart';
import 'package:flutter_firebase1/main.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        final credential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );

        print('Registration successful');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _showError('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          _showError('The account already exists for that email ok sumit.');
        } else {
          _showError(e.message!);
        }
      } catch (e) {
        _showError(e.toString());
      }
    }
  }

  void _showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Welcome to my app",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Enter Your Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password_outlined),
                  hintText: "Enter Your Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: _register,
                child: Text(
                  "Register Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(400, 50),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Already have an account"),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text("Sign in"),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.grey[400],
                    ),
                  ),
                  Text("or continue with"),
                  Expanded(
                      child: Divider(
                    thickness: 1.0,
                    color: Colors.grey[400],
                  )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white),
                        color: Colors.grey),
                    child: Image.network(
                      "https://lh3.googleusercontent.com/COxitqgJr1sJnIDe8-jiKhxDx1FrYbtRHKJ9z_hELisAlapwE9LUPh6fcXIfb5vwpbMl4xl9H9TRFPc5NOO8Sb3VSgIBrfRYvW6cUA",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white),
                          color: Colors.grey),
                      child: Image.network(
                        'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-768x432.png',
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
