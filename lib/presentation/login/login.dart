import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data_source/network/network.dart';
import '../home/home.dart';
import '../register/registro.dart';

class Login extends StatelessWidget {
  //Login({required BaseService baseService, Key? key})

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool emailValid(email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //BaseService _baseService;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Home()),
        // );
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Ingresar',
                      style: TextStyle(fontSize: 20),
                    )),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (!emailValid(value)) {
                              return 'Ingrese un Email válido';
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Ingrése un Email válido ',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Ingrese el password';
                            }
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Ingrése su password',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          signInWithGoogle();
                        },
                        child: const Text(
                          'Olvidé el password',
                        ),
                      ),
                      Container(
                        height: 80,
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              //if (true) {
                              Map<String, dynamic> loginJson = {
                                'username': emailController.text,
                                'password': passwordController.text,
                                'grant_type': 'password'
                              };
                              print(loginJson);
                              var response = await BaseService().postReq(
                                  url:
                                      'https://mobe-backend.herokuapp.com/oauth/token',
                                  body: loginJson,
                                  headers: <String, String>{
                                    'authorization':
                                        'Basic Zmx1dHRlcmFwcDoxMjM0NQ==',
                                  },
                                  contentType:
                                      'application/x-www-form-urlencoded');

                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');
                              if (response.statusCode == 200) {
                                List<dynamic> list = [];

                                var response2 = await BaseService().getReq(
                                  url:
                                      'https://mobe-backend.herokuapp.com/api/categorias',
                                  headers: <String, String>{
                                    'authorization':
                                        'Bearer ${response.body['access_token']}',
                                  },
                                );
                                print('response2  ${response2.body}');

                                list = response2.body
                                    .map((data) => Categoria.fromJson(data))
                                    .toList();
                                print('list ${list}');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home(list: list)),
                                );
                              }
                              //Firebase login
                              // try {
                              //   UserCredential userCredential =
                              //       await FirebaseAuth.instance
                              //           .signInWithEmailAndPassword(
                              //               email: emailController.text,
                              //               password: passwordController.text);
                              //
                              //   print(userCredential.credential?.token);
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const Home()),
                              //   );
                              // } on FirebaseAuthException catch (e) {
                              //   if (e.code == 'user-not-found') {
                              //     print('No user found for that email.');
                              //   } else if (e.code == 'wrong-password') {
                              //     print(
                              //         'Wrong password provided for that user.');
                              //   }
                              // }
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Text('No tienes una cuenta?'),
                    TextButton(
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Register(
                                  //baseService: _baseService,
                                  )),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )));
  }
}
