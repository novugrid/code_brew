import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// This can display profile images of users
/// in circular format, squar, rectangle, or custom size
/// Add icon for edit or tap for edit
class UIProfileImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UIProfileImageState();
}

class _UIProfileImageState extends State<UIProfileImage> {
  // File imageFile;
  ValueNotifier<File> imageFileNotifier = ValueNotifier(null);
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
  }

  void pickImage() async {
    /*Scaffold.of(context).showBottomSheet((context) {
      return ImageSourceChooser();
    });*/
    PickedFile pickedFile;
    UIImageChooser uiImageChooser = await showModalBottomSheet(
        context: context,
        builder: (con) {
          return ImageSourceChooser();
        });

    if (uiImageChooser != null) {
      switch (uiImageChooser) {
        case UIImageChooser.GALLERY:
          pickedFile = await picker.getImage(source: ImageSource.gallery);

          imageFileNotifier.value = File(pickedFile.path);
          break;
        case UIImageChooser.CAMERA:
          pickedFile = await picker.getImage(source: ImageSource.camera);
          imageFileNotifier.value = File(pickedFile.path);
          break;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          this.pickImage();
        },
        child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(color: Colors.grey),
            child: ValueListenableBuilder(
                valueListenable: imageFileNotifier,
                builder: (BuildContext context, File value, Widget child) {
                  return value != null ? Image.file(value) : Container();
//            return Container();
                })),
      ),
    );
  }
}

enum UIImageChooser { CAMERA, GALLERY }

class ImageSourceChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        children: <Widget>[
          item(context, UIImageChooser.GALLERY, "Select From Gallery", icon: Icons.image),
          SizedBox(
            height: 9,
          ),
          item(context, UIImageChooser.CAMERA, "Select From Camera", icon: Icons.camera_alt),
        ],
      ),
    );
  }

  Widget item(BuildContext context, UIImageChooser sourceChooser, String title, {IconData icon}) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop(sourceChooser);
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), border: Border.all(color: Theme.of(context).primaryColor)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15.0),
        child: Row(
          children: <Widget>[
            icon != null
                ? Container(
                    margin: EdgeInsets.only(right: 20.0),
                    child: Icon(
                      icon,
                      size: 32,
                      color: Theme.of(context).accentColor,
                    ),
                  )
                : Container(),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
