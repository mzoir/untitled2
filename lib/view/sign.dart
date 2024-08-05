import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';
import 'log.dart'; // Assuming 'log.dart' contains the login page

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String? error1;
  String? succed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title Text
                    Text(
                      'Tourism Register',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25.5,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Name TextFormField
                    TextFormField(
                      controller: nameController,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color(0xffa9a9a8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color(0xff023dff),
                          ),
                        ),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      cursorColor: Color(0xff08d9ac),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        } else if (value.length < 5) {
                           return 'name must have a least 5 widget ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    // Email TextFormField
                     TextFormField(
                      controller: emailController,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color(0xffa9a9a8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value) ) {
                          return 'Please enter  OO a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    // Password TextFormField
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color(0xffa9a9a8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 7) {
                          return 'Password must be at least 7 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          final name = nameController.text.trim();

                          try {
                            UserCredential userCredential =
                            await _auth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            if (userCredential.user != null) {
                              String uid = userCredential.user!.uid;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .set({'Name': name});

                              setState(() {
                                succed = 'Sign up successful. Please log in.';
                              });

                              print('Sign up successful');
                              // Navigate to the login page
                              await FirebaseAuth.instance.signOut();
                            }
                          } on FirebaseAuthException catch (e) {
                            print('Error: ${e.message}');
                            setState(() {
                              error1 = e.message;
                            });
                          } catch (e) {
                            print('Error: $e');
                            setState(() {
                              error1 = 'An unexpected error occurred.';
                            });
                          }
                        }
                      },
                      child: Text('Sign up'),
                    ),
                    if (error1 != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          error1!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    if (succed != null)
                      Padding(
                           padding: const EdgeInsets.only(top: 10.0), child: Text(succed!,
                        style: TextStyle(color: Colors.green),
      ),
          ),
                    SizedBox(height: 10.0),
                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
