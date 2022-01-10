import 'dart:io';
import "package:image_picker/image_picker.dart";
import 'package:flutter/material.dart';
import "package:path/path.dart" as path;
import "package:path_provider/path_provider.dart" as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile != null) {
      setState(() {
        _storedImage = File(imageFile.path);
      });
      final appDir = await syspath.getApplicationDocumentsDirectory();
      final filename = path.basename(imageFile.path);
      final savedImage =
          await File(imageFile.path).copy("${appDir.path}/$filename");
      widget.onSelectImage(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: _storedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _storedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
              : const Text(
                  "No Image Choosen",
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: TextButton.icon(
                style: TextButton.styleFrom(
                    textStyle:
                        TextStyle(color: Theme.of(context).primaryColor)),
                onPressed: _takePicture,
                icon: const Icon(Icons.camera),
                label: const Text("Take Picture")))
      ],
    );
  }
}
