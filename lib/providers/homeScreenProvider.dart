import 'dart:convert';

import 'package:dalle_openai_flutter_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenProvider extends ChangeNotifier {
  List dalleData = [];
  var dalleImage;
  getAllGeneratedImages() async {
    // Get all generated images......
    var res = await http.get(Uri.parse("${baseUrl}/api/v1/post"));

    var data = jsonDecode(res.body);

    print("----------  BODY  -------     " + jsonDecode(res.body).toString());

    dalleData = await jsonDecode(res.body)['data'];

    notifyListeners();
  }

  // an armchair in the shape of an avocado

  bool generatingImageLoading = false;

  generateImage(String prompt) async {
    /// generate image from this api
    generatingImageLoading = true;
    notifyListeners();

    Map data = {
      'prompt': prompt.toString(),
    };

    var body = json.encode(data);

    var res = await http.post(
      Uri.parse("${baseUrl}/api/v1/dalle"),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    dalleImage = await jsonDecode(res.body);

    print("RESULT ---------       " + dalleImage['photo'].toString());

    generatingImageLoading = false;

    notifyListeners();
  }
}
