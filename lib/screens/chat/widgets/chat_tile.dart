import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_admin/models/user_model.dart';
import 'package:travel_admin/providers/chat_provider.dart';
import 'package:travel_admin/screens/chat/chat_room.dart';

class ChatTile extends StatelessWidget {
  final String roomId;
  final ChatTileModel chatModel;
  ChatTile({@required this.roomId, this.chatModel});
  final uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(ChatRoom.routeName, arguments: {
        'chatRoomId': roomId,
        'user': chatModel.user,
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(chatModel.user.imageUrl),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      chatModel.user.fullName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      DateFormat('HH:mm').format(chatModel.time.toDate()),
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    )
                  ],
                ),
                Text(
                  '${chatModel.latestMessageSenderId == uid ? 'You: ' : ''}${chatModel.latestMessage}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
