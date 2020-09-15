import 'package:flutter/material.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:loja_online/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailConroller = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ),
            child: Text(
              "Entrar",
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Nome"),
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Nome inválido";
                    }
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _emailConroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "E-mail"),
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@")) {
                      return "Email inválido";
                    }
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Senha"),
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha inválida";
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(hintText: "Endereço"),
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty) return "Endereço inválido";
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailConroller.text,
                          "address": _addressController.text
                        };

                        model.signUp(userData, _passController.text, _onSuccess,
                            _onFail);
                      }
                    },
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {}
  void _onFail() {}
}
