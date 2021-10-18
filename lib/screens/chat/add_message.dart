import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/models/message_model.dart';
import 'package:travel_admin/providers/chat_provider.dart';

class AddMessage extends StatefulWidget {
  final String userId;
  AddMessage({@required this.userId});

  @override
  _AddMessageState createState() => _AddMessageState();
}

class _AddMessageState extends State<AddMessage> {
  final TextEditingController messageController = TextEditingController();
  List<Media> mediaList = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey[300]),
              child: TextField(
                controller: messageController,
                maxLines: null,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    border: InputBorder.none,
                    prefixIcon: GestureDetector(
                        onTap: () => openImagePicker(context),
                        child: Icon(Icons.camera_alt_rounded, color: kPrimary)),
                    hintText: 'Message'),
              ),
            ),
          ),
          CircleAvatar(
            radius: 23,
            backgroundColor: kPrimary,
            child: IconButton(
              splashRadius: 25,
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: () {
                Provider.of<ChatProvider>(context, listen: false).sendMessage(
                    widget.userId,
                    MessageModel(
                      message: messageController.text,
                      senderId: FirebaseAuth.instance.currentUser.uid,
                      receiverId: widget.userId,
                    ));
                messageController.clear();
              },
            ),
          ),
          SizedBox(
            width: 5,
          )
        ],
      ),
    );
  }

  void openImagePicker(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 0.95,
                minChildSize: 0.6,
                builder: (ctx, controller) => AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    color: Colors.white,
                    child: MediaPicker(
                      scrollController: controller,
                      mediaList: mediaList,
                      onPick: (selectedList) {
                        setState(() => mediaList = selectedList);
                        Navigator.pop(context);
                      },
                      onCancel: () => Navigator.pop(context),
                      mediaCount: MediaCount.multiple,
                      mediaType: MediaType.image,
                      decoration: PickerDecoration(
                        cancelIcon: Icon(Icons.close),
                        albumTitleStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        actionBarPosition: ActionBarPosition.top,
                        blurStrength: 2,
                        completeText: 'Change',
                      ),
                    )),
              ));
        }).then((_) async {
      if (mediaList.isNotEmpty) {
        double mediaSize =
            mediaList.first.file.readAsBytesSync().lengthInBytes /
                (1024 * 1024);

        if (mediaSize < 1.0001) {
          Provider.of<ChatProvider>(context, listen: false).sendMessage(
              widget.userId,
              MessageModel(
                message: '',
                mediaFiles: mediaList.map((e) => e.file).toList(),
                mediaType: 'image',
                senderId: FirebaseAuth.instance.currentUser.uid,
                receiverId: widget.userId,
              ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image should be less than 1 MB')));
        }
      }
    });
  }
}
