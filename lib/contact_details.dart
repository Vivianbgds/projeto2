import 'package:flutter/material.dart';
import 'contact.dart';
import 'edit_contact.dart';

class ContactDetails extends StatefulWidget {
  final Contact contact;
  final int index;
  const ContactDetails({super.key, required this.contact, required this.index});

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Contato'),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: ThemeData.dark().canvasColor,
            borderRadius: BorderRadius.circular(1)),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple[200],
              child: Text(
                widget.contact.name[0].toUpperCase(),
                style: const TextStyle(fontSize: 50),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.contact.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.contact.phoneNumber,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.contact.email,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(color: ThemeData.dark().canvasColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditContact(contact: widget.contact);
                })).then((value) {
                  if (value != null) {
                    Navigator.pop(context, value);
                  }
                });
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirme"),
                        content: const Text(
                            "Tem certeza que deseja excluir esse contato?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("CANCELAR"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context, widget.contact);
                            },
                            child: const Text("APAGAR"),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
