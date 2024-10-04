import 'package:flutter/material.dart';
import 'package:tt9_quran_app/asset.dart';
import 'package:tt9_quran_app/network.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Asset asset = Asset();
  Network network = Network();
  int pageNumber = 1;
  List<dynamic> ayahs = [];
  void getData() async {
    ayahs = await asset.fetchData(pageNumber);
    setState(() {});
    //صار شغل قديم
    // Map<String, dynamic> pageData = await network.fetchData(pageNumber);
    // setState(() {
    //   ayahs = pageData['data']['ayahs'];
    // });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          itemBuilder: (context, index) {
            pageNumber = index + 1;
            getData();
            return Row(
              textDirection:
                  pageNumber % 2 == 0 ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: pageNumber % 2 == 0
                            ? LinearGradient(colors: [
                                Color(0xfff1cda6),
                                Color(0xffffeec6),
                                Color(0xfffdfcfa),
                              ])
                            : LinearGradient(colors: [
                                Color(0xfffdfcfa),
                                Color(0xffffeec6),
                                Color(0xfff1cda6),
                              ])),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text.rich(TextSpan(
                            children: [
                              for (int i = 0; i < ayahs.length; i++) ...{
                                TextSpan(
                                    text: '${ayahs[i]['aya_text_emlaey']} ',
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'HafsSmart')),
                              }
                            ],
                          )),
                        ),
                        Spacer(),
                        Text(pageNumber.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
