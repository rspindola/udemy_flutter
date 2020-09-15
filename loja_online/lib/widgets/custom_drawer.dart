import 'package:flutter/material.dart';
import 'package:loja_online/screens/login_screen.dart';

import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                height: 170.0,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Hamburgueria",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Olá,",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              "Entre ou cadastre-se",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.list, "Categorias", pageController, 1),
              DrawerTile(
                  Icons.location_on, "Encontre uma loja", pageController, 2),
              DrawerTile(
                  Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
