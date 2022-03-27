import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data_source/network/network.dart';
import '../home/home.dart';
import '../register/registro.dart';

class Login extends StatelessWidget {
  Login({required BaseService baseService, Key? key})
      : _baseService = baseService,
        super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool emailValid(email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  BaseService _baseService;
  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {},
                        child: const Text(
                          'Olvidé el password',
                        ),
                      ),
                      Container(
                        height: 80,
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Map<String, dynamic> loginJson = {
                                'username': emailController.text,
                                'password': passwordController.text,
                                'grant_type': 'password'
                              };
                              print(loginJson);
                              _baseService.postReq(url: 'url', body: loginJson);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              );
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
                                    baseService: _baseService,
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

// bool emailValid = RegExp(
//         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//     .hasMatch(email);
