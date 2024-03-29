import 'dart:io';

import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  // Constructor
  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = const Color.fromRGBO(64, 105, 225, 1);
    final ThemeData theme = Theme.of(context);
    return Center(
        child: Stack(children: [
      buildImage(
        theme,
        color,
      ),
      // Positioned(
      //   // child: buildEditIcon(color),
      //   right: 4,
      //   top: 10,
      // ),
    ]));
  }

  // Builds Profile Image
  Widget buildImage(ThemeData theme, Color color) {
    final image = imagePath.contains('https://')
        ? Image.network(
            imagePath,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Icon(
                Icons.error,
                color: theme.colorScheme.error,
              );
            },
          )
        : Image.file(
            File(imagePath),
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Icon(
                Icons.error,
                color: theme.colorScheme.error,
              );
            },
          );

    return ClipRRect(
        borderRadius: BorderRadius.circular(300),
        child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(),
            height: 120,
            width: 120,
            child: image));
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
