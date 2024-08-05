import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'sign.dart';
import 'forpass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? error1;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/18.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Toursime Login',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 25.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required field';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: Color(0xffa9a9a8),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: Color(0xff023dff),
                        ),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    cursorColor: Color(0xff08d9ac),
                  ),
                  SizedBox(height: 16.0),

                  TextFormField(
                    controller: passwordController,
                    obscureText: false,

                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required field';
                      } else if (value.length < 7) {
                        return 'Password must be at least 7 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: Color(0xffa9a9a8),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: Color(0xff023dff),
                        ),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    cursorColor: Color(0xff08d9ac),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        try {
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HoMepa(email: email),
                            ),
                          );
                          print('Login successful');
                        } catch (e) {
                          print(e);
                          setState(() {
                            error1 = e.toString();
                          });
                        }
                      }
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 10.0),
                  if (error1 != null)
                    Text(
                      error1!,
                      style: TextStyle(color: Colors.yellow,fontSize: 18),
                    ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPasswordPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Forget Password!',
                      style: TextStyle(color: Colors.blue,  fontWeight: FontWeight.bold,),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Sign(),
                        ),
                      );
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
