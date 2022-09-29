import 'dart:convert';
import 'package:contact_list/add_contact.dart';
import 'package:contact_list/contact.dart';
import 'package:contact_list/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contact_details.dart';
import 'list_tile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    home: const Login(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  List<Contact> list = [];

  setupContact() async {
    prefs = await SharedPreferences.getInstance();
    String? stringContact = prefs.getString('contact');
    if (stringContact != null) {
      List contactList = jsonDecode(stringContact);
      for (var element in contactList) {
        setState(() {
          list.add(Contact.fromJson(element));
        });
      }
    }
  }

  saveContact() {
    List items = list.map((e) => e.toJson()).toList();
    prefs.setString('contact', jsonEncode(items));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Contatos',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirme"),
                          content: const Text(
                              "Tem certeza que deseja excluir esse contato?"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("CANCELAR")),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("APAGAR"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    setState(() {
                      list.removeAt(index);
                    });
                    saveContact();
                  },
                  key: Key(list[index].name.toString()),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactDetails(
                                      contact: list[index],
                                      index: index,
                                    ))).then((value) {
                          if (value != null) {
                            if (value.name != list[index].name ||
                                value.phoneNumber != list[index].phoneNumber ||
                                value.email != list[index].email) {
                              setState(() {
                                list[index] = value;
                              });
                            } else {
                              setState(() {
                                bool removed = list.remove(value);
                                removed
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Contato removido com sucesso!')))
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Erro ao remover contato!')));
                              });
                            }
                            saveContact();
                          }
                        });
                      },
                      child: ListTileWidget(contact: list[index])));
            }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddContact();
            })).then((value) {
              if (value != null) {
                setState(() {
                  list.add(value);
                });
                saveContact();
              }
            });
          },
        ));
  }
}
