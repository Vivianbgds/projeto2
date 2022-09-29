import 'package:contact_list/contact.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatefulWidget {
  final Contact contact;
  const ListTileWidget({super.key, required this.contact});

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepPurple[200],
        child: Text(
          widget.contact.name[0].toUpperCase(),
          style: TextStyle(
              fontSize: 20,
              color: ThemeData.dark().primaryTextTheme.bodyText1!.color),
        ),
      ),
      title: Text(
        widget.contact.name,
        style: TextStyle(
            fontSize: 20,
            color: ThemeData.dark().primaryTextTheme.bodyText1!.color,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
