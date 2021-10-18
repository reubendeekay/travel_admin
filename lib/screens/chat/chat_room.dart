import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/models/message_model.dart';
import 'package:travel_admin/models/user_model.dart';
import 'package:travel_admin/screens/chat/add_message.dart';
import 'package:travel_admin/screens/chat/widgets/chat_bubble.dart';
import 'package:travel_admin/screens/chat/widgets/chat_tile.dart';

class ChatRoom extends StatelessWidget {
  static const routeName = '/chat-room';
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final chatRoomData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final UserModel user = chatRoomData['user'];
    final chatRoomId = chatRoomData['chatRoomId'];

    build(BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollController
          .animateTo(_scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 200), curve: Curves.easeInOut));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        leadingWidth: 25,
        title: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 21,
              backgroundImage: CachedNetworkImageProvider(user.imageUrl),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                child: Text(
                  user.fullName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: Icon(
              Icons.videocam_rounded,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
          moreVert()
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(chatRoomId)
                    .collection('messages')
                    .orderBy('sentAt')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      // reverse: true,
                      controller: _scrollController,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        final message = snapshot.data.docs[index];

                        build(context);
                        return ChatBubble(MessageModel(
                          message: message['message'],
                          isRead: message['isRead'],
                          sentAt: message['sentAt'],
                          senderId: message['sender'],
                          mediaType: message['mediaType'],
                          mediaUrl: message['media'],
                        ));
                      },
                    ),
                  );
                }),
            AddMessage(
              userId: user.userId,
            ),
            SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }

  Widget moreVert() {
    return PopupMenuButton(
        elevation: 1,
        itemBuilder: (xtx) => options
            .map((e) => PopupMenuItem(
                    child: Text(
                  e,
                  style: TextStyle(fontSize: 15),
                )))
            .toList(),
        icon: Icon(
          Icons.more_vert,
          color: Colors.grey,
        ));
  }

  List options = [
    'Search',
    'Mute notifications',
    'Clear chat',
    'Report',
    'Block'
  ];
}
