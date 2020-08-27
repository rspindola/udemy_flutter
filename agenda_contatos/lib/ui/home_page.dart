import 'dart:io';

import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:agenda_contatos/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions { orderAz, orderZa }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();

    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos"),
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                  child: Text("Ordenar de A-Z"), value: OrderOptions.orderAz),
              const PopupMenuItem<OrderOptions>(
                  child: Text("Ordenar de Z-A"), value: OrderOptions.orderZa)
            ],
            onSelected: _orderList,
          )
        ],
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white70,
      floatingActionButton: FloatingActionButton(
        onPressed: _showContactPage,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _contectCard(context, index);
          }),
    );
  }

  Widget _contectCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _showOptions(context, index);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contacts[index].img != null
                          ? FileImage(File(contacts[index].img))
                          : AssetImage("images/person.png")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contacts[index].name ?? "Nao informado",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contacts[index].email ?? "Nao informado",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      contacts[index].phone ?? "Nao informado",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderAz:
        contacts.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OrderOptions.orderZa:
        contacts.sort((a, b) {
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
      default:
    }

    setState(() {});
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                          onPressed: () {
                            launch("tel:${contacts[index].phone}");
                          },
                          child: Text(
                            "Ligar",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showContactPage(contact: contacts[index]);
                          },
                          child: Text(
                            "Editar",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                          onPressed: () {
                            helper.deleteContact(contacts[index].id);
                            setState(() {
                              contacts.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          )),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  void _showContactPage({Contact contact}) async {
    final _recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));
    if (_recContact != null) {
      if (contact != null) {
        await helper.updateContact(_recContact);
      } else {
        await helper.saveContact(_recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }
}
