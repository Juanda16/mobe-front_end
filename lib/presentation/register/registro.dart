import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data_source/network/network.dart';
import '../login/login.dart';

class Register extends StatelessWidget {
  Register({required BaseService baseService, Key? key})
      : _baseService = baseService,
        super(key: key);
  final _formKey = GlobalKey<FormState>();

  BaseService _baseService;
  TextEditingController textEditingController = TextEditingController();

  bool emailValid(email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  bool phoneValid(phone) =>
      RegExp(r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$')
          .hasMatch(phone);

  @override
  Widget build(BuildContext context) {
    String? id;
    String? name;
    String? lastName;
    String? email;
    String? password;
    String? phone;
    String? address;
    String? department;
    String? city;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Registro'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Regístrate!',
                      style: TextStyle(fontSize: 20),
                    )),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Ingrese el ID';
                            }
                          },
                          onSaved: (String? value) {
                            id = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Id',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          onSaved: (String? value) {
                            name = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Ingrese el celular';
                            }
                          },
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nombre',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          onSaved: (String? value) {
                            lastName = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Ingrese el apellido';
                            }
                          },
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Apellido',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          onSaved: (String? value) {
                            email = value;
                          },
                          validator: (value) {
                            if (!emailValid(value)) {
                              return 'Ingrese un Email válido';
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          onSaved: (String? value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Ingrese el password';
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Contraseña',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          onSaved: (String? value) {
                            phone = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Ingrese el celular';
                            }
                          },
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Celular',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          onSaved: (String? value) {
                            address = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Ingrese la dirección';
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Dirección',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          onSaved: (String? value) {
                            department = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Ingrese el departamento';
                            }
                          },
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Departamento',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          onSaved: (String? value) {
                            city = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Ingrese la ciudad';
                            }
                          },
                          keyboardType: TextInputType.text,
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ciudad',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            child: const Text('Estoy Listo!'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                Map<String, dynamic> registerJson = {
                                  'id': id,
                                  'name': name,
                                  'lastName': lastName,
                                  'email': email,
                                  'password': password,
                                  'phone': phone,
                                  'address': address,
                                  'department': department,
                                  'city': city,
                                };
                                print(registerJson);
                                Navigator.pop(context);
                              }
                            },
                          )),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Text('Ya tienes una cuenta?'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login(
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
