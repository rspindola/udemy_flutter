import 'package:flutter/material.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:loja_online/screens/cadastro_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => CadastroScreen()),
            ),
            child: Text(
              "Criar Conta",
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
          else
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "E-mail"),
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
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Senha"),
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha Inválida";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () => null,
                      padding: EdgeInsets.zero,
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                    ),
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
                          print("entrou");
                        }

                        model.signIn();
                      },
                      child: Text(
                        "Entrar",
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
}
