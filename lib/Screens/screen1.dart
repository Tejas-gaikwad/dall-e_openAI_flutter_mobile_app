import 'package:dalle_openai_flutter_app/Screens/screen2.dart';
import 'package:dalle_openai_flutter_app/providers/homeScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final homeProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);
    homeProvider.getAllGeneratedImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeScreenProvider>(
          builder: (context, homeProvider, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    height: 250,
                    color: Color.fromRGBO(163, 198, 22, 1),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Screen2();
                          },
                        ));
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        color: Color.fromARGB(255, 22, 95, 198),
                        child: Text(
                          "Generate Image".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // homeProvider.getAllGeneratedImages();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      color: Colors.grey.withOpacity(0.3),
                      child: const Text("All Generated Images"),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Colors.grey.withOpacity(0.2),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: homeProvider.dalleData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 18, 5, 195)
                                .withOpacity(0.6),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                homeProvider.dalleData[index]['photo']
                                    .toString(),
                                height: 150,
                              ),
                              SizedBox(height: 10),
                              Text(
                                homeProvider.dalleData[index]['name']
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                homeProvider.dalleData[index]['prompt']
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
