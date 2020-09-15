import 'package:flutter/material.dart';
import 'package:loja_online/tabs/categories_tab.dart';
import 'package:loja_online/tabs/home_tab.dart';
import 'package:loja_online/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          drawer: CustomDrawer(_pageController),
          body: HomeTab(),
        ),
        Scaffold(
          drawer: CustomDrawer(_pageController),
          appBar: AppBar(
            title: Text("Categorias"),
            centerTitle: true,
          ),
          body: CategoriesTab(),
        ),
        Scaffold(
          drawer: CustomDrawer(_pageController),
          appBar: AppBar(
            title: Text("Encontre uma loja"),
            centerTitle: true,
          ),
          body: Container(
            color: Colors.green,
          ),
        ),
        Scaffold(
          drawer: CustomDrawer(_pageController),
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: Container(
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
