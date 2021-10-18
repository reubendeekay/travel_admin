import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_admin/models/message_model.dart';
import 'package:travel_admin/models/user_model.dart';

class ChatTileModel {
  final UserModel user;
  String latestMessage;
  Timestamp time;
  final String latestMessageSenderId;
  final String chatRoomId;

  ChatTileModel({
    this.user,
    this.latestMessage,
    this.time,
    this.chatRoomId,
    this.latestMessageSenderId,
  });
}

class ChatProvider with ChangeNotifier {
  List<ChatTileModel> _contactedUsers = [];

  List<ChatTileModel> get contactedUsers => [..._contactedUsers];

  /////////////////SEND MESSAGE////////////////////////
  Future<void> sendMessage(String userId, MessageModel message) async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    List<String> urls = [];
    String mediaType = 'image';

    if (message.mediaFiles.isNotEmpty) {
      await Future.forEach(message.mediaFiles, (element) async {
        final fileData = await FirebaseStorage.instance
            .ref('chatFiles/$uid/${DateTime.now().toIso8601String()}')
            .putFile(element);
        final url = await fileData.ref.getDownloadURL();
        urls.add(url);
      }).then((_) async {
        final initiator = FirebaseFirestore.instance
            .collection('chats')
            .doc(uid + '_' + userId);
        final receiver = FirebaseFirestore.instance
            .collection('chats')
            .doc(userId + '_' + uid);

        initiator.get().then((value) => {
              if (value.exists)
                {
                  initiator.update({
                    'latestMessage':
                        message.message.isNotEmpty ? message.message : 'photo',
                    'sentAt': Timestamp.now(),
                    'sentBy': uid,
                  }),
                  initiator.collection('messages').doc().set({
                    'message': message.message != null ? message.message : '',
                    'sender': uid,
                    'media': urls,
                    'mediaType': mediaType,
                    'isRead': false,
                    'sentAt': Timestamp.now()
                  })
                }
              else
                {
                  receiver.get().then((value) => {
                        if (value.exists)
                          {
                            receiver.update({
                              'latestMessage': message.message.isNotEmpty
                                  ? message.message
                                  : 'photo',
                              'sentAt': Timestamp.now(),
                              'sentBy': uid,
                            }),
                            receiver.collection('messages').doc().set({
                              'message': message.message != null
                                  ? message.message
                                  : '',
                              'sender': uid,
                              'media': urls,
                              'mediaType': mediaType,
                              'isRead': false,
                              'sentAt': Timestamp.now()
                            })
                          }
                        else
                          {
                            initiator.set({
                              'initiator': uid,
                              'receiver': userId,
                              'startedAt': Timestamp.now(),
                              'latestMessage': message.message.isNotEmpty
                                  ? message.message
                                  : '',
                              'sentAt': Timestamp.now(),
                              'sentBy': uid,
                            }),
                            initiator.collection('messages').doc().set({
                              'message': message.message != null
                                  ? message.message
                                  : '',
                              'sender': uid,
                              'media': urls,
                              'mediaType': mediaType,
                              'isRead': false,
                              'sentAt': Timestamp.now()
                            }),
                          }
                      })
                }
            });
      });
    } else {
      final initiator = FirebaseFirestore.instance
          .collection('chats')
          .doc(uid + '_' + userId);
      final receiver = FirebaseFirestore.instance
          .collection('chats')
          .doc(userId + '_' + uid);

      initiator.get().then((value) => {
            if (value.exists)
              {
                initiator.update({
                  'latestMessage':
                      message.message != null ? message.message : 'photo',
                  'sentAt': Timestamp.now(),
                  'sentBy': uid,
                }),
                initiator.collection('messages').doc().set({
                  'message': message.message != null ? message.message : '',
                  'sender': uid,
                  'media': urls.isNotEmpty ? urls : [],
                  'mediaType': mediaType,
                  'isRead': false,
                  'sentAt': Timestamp.now()
                })
              }
            else
              {
                receiver.get().then((value) => {
                      if (value.exists)
                        {
                          receiver.update({
                            'latestMessage': message.message != null
                                ? message.message
                                : 'photo',
                            'sentAt': Timestamp.now(),
                            'sentBy': uid,
                          }),
                          receiver.collection('messages').doc().set({
                            'message':
                                message.message != null ? message.message : '',
                            'sender': uid,
                            'media': message.mediaUrl != null
                                ? message.mediaUrl
                                : [],
                            'mediaType': mediaType,
                            'isRead': false,
                            'sentAt': Timestamp.now()
                          })
                        }
                      else
                        {
                          initiator.set({
                            'initiator': uid,
                            'receiver': userId,
                            'startedAt': Timestamp.now(),
                            'latestMessage':
                                message.message != null ? message.message : '',
                            'sentAt': Timestamp.now(),
                            'sentBy': uid,
                          }),
                          initiator.collection('messages').doc().set({
                            'message':
                                message.message != null ? message.message : '',
                            'sender': uid,
                            'media': urls.isNotEmpty ? urls : [],
                            'mediaType': mediaType,
                            'isRead': false,
                            'sentAt': Timestamp.now()
                          }),
                        }
                    })
              }
          });
    }
  }

  //////////////////////////////////////////////////////
  ///
  ///
  Future<void> getChats() async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    List<ChatTileModel> users = [];

    final initiatorChats = await FirebaseFirestore.instance
        .collection('chats')
        .where('initiator', isEqualTo: uid)
        .get();
    final receiverChats = await FirebaseFirestore.instance
        .collection('chats')
        .where('receiver', isEqualTo: uid)
        .get();

    await Future.forEach(initiatorChats.docs, (element) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(element['receiver'])
          .get()
          .then((value) => {
                // print(value['fullName']),
                if (value.exists)
                  {
                    users.add(
                      ChatTileModel(
                          chatRoomId: element.id,
                          latestMessageSenderId: element['sentBy'],
                          user: UserModel(
                            fullName: value['fullName'],
                            imageUrl: value['profilePic'],
                            userId: value['userId'],
                            phoneNumber: value['phoneNumber'],
                          ),
                          latestMessage: element['latestMessage'],
                          time: element['sentAt']),
                    ),
                  }
              });
    });

    await Future.forEach(receiverChats.docs, (element) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(element['initiator'])
          .get()
          .then((value) => {
                if (value.exists)
                  {
                    users.add(
                      ChatTileModel(
                          chatRoomId: element.id,
                          latestMessageSenderId: element['sentBy'],
                          user: UserModel(
                            fullName: value['fullName'],
                            imageUrl: value['profilePic'],
                            userId: value['userId'],
                            phoneNumber: value['phoneNumber'],
                          ),
                          latestMessage: element['latestMessage'],
                          time: element['sentAt']),
                    ),
                  }
              });
    });

    _contactedUsers = users;
    print('running');

    notifyListeners();
  }
}
