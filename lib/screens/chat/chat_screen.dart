import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/providers/chat_provider.dart';
import 'package:travel_admin/screens/chat/chat_screen_search.dart';
import 'package:travel_admin/screens/chat/widgets/chat_tile.dart';

class ChatScreen extends StatelessWidget {
  final _controller = ScrollController();
  final uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final contacts = Provider.of<ChatProvider>(context).contactedUsers;
    Provider.of<ChatProvider>(context).getChats();

    return Scaffold(
      appBar: ScrollAppBar(
        controller: _controller,
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          height: 70,
          alignment: Alignment.bottomLeft,
          child: Text(
            'Chat',
            style: GoogleFonts.barlow(
                fontSize: 34, fontWeight: FontWeight.w900, color: kPrimary),
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 10,
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(ChatScreenSearch.routeName);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Snap(
          controller: _controller.appBar,
          child: ListView(
            controller: _controller,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                    'Consult respective residence officials. Get to know where you will stay and avail any special request. ',
                    style: TextStyle(color: Colors.grey)),
              ),
              Divider(
                thickness: 1,
              ),
              ...List.generate(
                contacts.length,
                (index) => ChatTile(
                  roomId: contacts[index].chatRoomId,
                  chatModel: contacts[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
