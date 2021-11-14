import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

class AddAdScreen extends StatefulWidget {
  static const routeName = '/add-ad';

  @override
  _AddAdScreenState createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  final cropKey = GlobalKey<CropState>();
  File imageFile;
  List<Media> mediaList = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'POST AN AD',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: AspectRatio(
              aspectRatio: 5,
              child: Icon(Icons.camera),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openImagePicker(
    BuildContext context,
  ) async {
    // openCamera(onCapture: (image){
    //   setState(()=> mediaList = [image]);
    // });
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

                        imageFile = mediaList.first.file;
                        mediaList.clear();

                        Navigator.pop(context);
                      },
                      onCancel: () => Navigator.pop(context),
                      mediaCount: MediaCount.single,
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
        });
  }
}
