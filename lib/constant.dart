import 'package:flutter/material.dart';

String baseUrl = "https://dall-e-mern-project.onrender.com";

showSnacKBar(BuildContext context, String snackBarText) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: SnackBar(
        content: Text(snackBarText.toString()),
      ),
    ),
  );
}
   