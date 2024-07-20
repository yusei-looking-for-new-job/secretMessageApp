import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:stego_app/ViewModel/dataIO/saveImage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showDownloadDialog(BuildContext context, Uint8List image) async {
  // Flutterでダイアログを表示し、その中に画像を表示
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.embSuccess),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.memory(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Download Image'),
            onPressed: () async {
              await saveEncodedImage(image, context);
            },
          ),
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
