// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Api/getNewsByQuery.dart';
import 'package:newsapp/Screens/WebviewScreen.dart';

class CategoryScreen extends StatefulWidget {
  String categoryTitle;
  CategoryScreen({super.key, required this.categoryTitle});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final width = mq.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryTitle),
        ),
        body: FutureBuilder(
            future: getNewsByQuery(widget.categoryTitle),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewScreen(
                                        heading: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        url: snapshot.data!.articles![index].url
                                            .toString())));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 15,
                            shadowColor:
                                const Color.fromARGB(255, 216, 228, 239),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  width: double.maxFinite,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: snapshot.data!.articles![index]
                                                  .urlToImage !=
                                              null
                                          ? Image.network(snapshot
                                              .data!.articles![index].urlToImage
                                              .toString())
                                          : Image.asset(
                                              "assets/images/download.jpg",
                                              fit: BoxFit.fill,
                                              // height: double.maxFinite,
                                              // width: double.maxFinite,
                                            )),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    // height: height * 0.05,
                                    width: width * 0.93,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black,
                                              Colors.black.withOpacity(0.2)
                                            ])),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          snapshot.data!.articles![index]
                                                      .title !=
                                                  null
                                              ? Text(
                                                  snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Text(
                                                  "No Description Available"),
                                          snapshot.data!.articles![index]
                                                      .description !=
                                                  null
                                              ? Text(
                                                  snapshot
                                                              .data!
                                                              .articles![index]
                                                              .description!
                                                              .length >
                                                          40
                                                      ? snapshot
                                                          .data!
                                                          .articles![index]
                                                          .description
                                                          .toString()
                                                          .substring(0, 30)
                                                      : snapshot
                                                          .data!
                                                          .articles![index]
                                                          .description
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              : Text("No Description Available")
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
            }));
  }
}
