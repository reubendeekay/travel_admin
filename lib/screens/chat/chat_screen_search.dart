import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_admin/helpers/chat_tile_shimmer.dart';
import 'package:travel_admin/models/user_model.dart';
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
    // final contacts = Provider.of<ChatProvider>(context)
    //     .contactedUsers
    //     .where(
    //         (element) => element.user.fullName.contains(searchController.text))
    //     .toList();
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
        body: searchController.text.isEmpty
            ? StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (ctx, snapshots) {
                  if (!snapshots.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<DocumentSnapshot> users = snapshots.data.docs;
                    return ListView(
                      children: users
                          .map((e) => ChatTile(
                                chatModel: ChatTileModel(
                                    user: UserModel(
                                        address: e['address'],
                                        dateOfBirth: e['dateOfBirth'],
                                        email: e['email'],
                                        fullName: e['fullName'],
                                        nationalId: e['nationalId'],
                                        phoneNumber: e['phoneNumber'],
                                        imageUrl: e['profilePic'],
                                        userId: e['userId'],
                                        password: e['password'])),
                              ))
                          .toList(),
                    );
                  }
                },
              )
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('fullName',
                        isLessThanOrEqualTo:
                            searchController.text.toLowerCase())
                    .snapshots(),
                builder: (ctx, snapshots) {
                  if (!snapshots.hasData) {
                    return Center(
                      child: ListView(children: [
                        ChatTileShimmer(),
                        ChatTileShimmer(),
                        ChatTileShimmer(),
                        ChatTileShimmer(),
                        ChatTileShimmer(),
                        ChatTileShimmer(),
                        ChatTileShimmer(),
                        ChatTileShimmer(),
                        ChatTileShimmer(),
                      ]),
                    );
                  } else {
                    List<DocumentSnapshot> users = snapshots.data.docs;
                    return ListView(
                      children: users
                          .map((e) => ChatTile(
                                chatModel: ChatTileModel(
                                    user: UserModel(
                                        address: e['address'],
                                        dateOfBirth: e['dateOfBirth'],
                                        email: e['email'],
                                        fullName: e['fullName'],
                                        nationalId: e['nationalId'],
                                        phoneNumber: e['phoneNumber'],
                                        imageUrl: e['profilePic'],
                                        userId: e['userId'],
                                        password: e['password'])),
                              ))
                          .toList(),
                    );
                  }
                },
              ));
  }
}
