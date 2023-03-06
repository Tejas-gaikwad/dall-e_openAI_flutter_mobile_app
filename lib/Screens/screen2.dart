import 'dart:convert';
import 'dart:math';

import 'package:dalle_openai_flutter_app/providers/homeScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final homeProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);
    print("GENERATING IMAGE -----------    " +
        homeProvider.generatingImageLoading.toString());
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeScreenProvider>(
          builder: (context, homeProvider, child) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      textController.text =
                          "Hindu god krishna with many hands and many faces digital art";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(4.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      margin: const EdgeInsets.all(10),
                      child: Text("Random Prompt"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.all(10),
                    color: Colors.grey.withOpacity(0.3),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: "Enter text",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (textController.text.isNotEmpty) {
                        await homeProvider.generateImage(textController.text);
                      } else {
                        showSnacKBar(context, "Hey! Please enter prompt...");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      margin: const EdgeInsets.all(10),
                      color: Color.fromARGB(255, 5, 27, 171).withOpacity(0.6),
                      child: Text("Generate Image."),
                    ),
                  ),
                  SizedBox(height: 30),
                  homeProvider.dalleImage.toString() == "null"
                      ? Container(
                          child: Text("Create Image"),
                        )
                      : Container(
                          height: 400,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12.0)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: homeProvider.generatingImageLoading == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.blue))
                              : Image.memory(
                                  base64Decode(homeProvider.dalleImage['photo']
                                      .toString()),
                                  height: 350,
                                  fit: BoxFit.cover,
                                ),
                        ),
                  SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(  
                          "Share",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
