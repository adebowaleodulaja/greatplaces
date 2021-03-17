import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async{
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if(imageFile == null){
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName}');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text("No image taken.", textAlign: TextAlign.center,),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            label: Text("Take Picture"),
            icon: Icon(Icons.camera),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
          ),
        )
      ],
    );
  }
 }
