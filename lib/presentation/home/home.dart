import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login/login.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.list}) : super(key: key);

  final List list;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mobe'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            list.length,
            (index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/mobe.png',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      'Categoria ${list[index].name}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) async {
            print(index);
            if (index == 2) {
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            }
          },
          backgroundColor: Colors.lightBlue,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: "logout",
            )
          ],
        ));
  }
}

class Categoria {
  final String name;
  final int id;

  Categoria._({required this.name, required this.id});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return new Categoria._(
      name: json['name'],
      id: json['id'],
    );
  }

  @override
  String toString() {
    return 'Categoria{name: $name, id: $id}';
  }
}
