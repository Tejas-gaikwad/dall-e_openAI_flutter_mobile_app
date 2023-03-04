import 'package:dalle_openai_flutter_app/providers/homeScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeScreenProvider>(
          builder: (context, homeProvider, child) {
            return Container(
              child: Column(
                children: [
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
                      await homeProvider.generateImage();
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
                  homeProvider.generatingImageLoading == true
                      ? Center(
                          child: CircularProgressIndicator(color: Colors.blue))
                      : homeProvider.dalleImage.toString() == "null"
                          ? Container(
                              child: Text("Create Image"),
                            )
                          : Container(
                              child: Image.network(
                                "http://${homeProvider.dalleImage['photo'].toString()}",
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
