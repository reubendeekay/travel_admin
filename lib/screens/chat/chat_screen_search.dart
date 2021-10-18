import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/providers/chat_provider.dart';
import 'package:travel_admin/screens/chat/widgets/chat_tile.dart';

class ChatScreenSearch extends StatefulWidget {
  static const routeName = '/chat-screen-search';

  @override
  _ChatScreenSearchState createState() => _ChatScreenSearchState();
}

class _ChatScreenSearchState extends State<ChatScreenSearch> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final contacts = Provider.of<ChatProvider>(context)
        .contactedUsers
        .where(
            (element) => element.user.fullName.contains(searchController.text))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: TextField(
          controller: searchController,
          autofocus: true,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView(
        children: [
          if (searchController.text.isNotEmpty)
            ...List.generate(
                contacts.length,
                (index) => ChatTile(
                      roomId: contacts[index].chatRoomId,
                      chatModel: contacts[index],
                    ))
        ],
      ),
    );
  }
}
