import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Api/getNewsByQuery.dart';
import 'package:newsapp/Api/gettopheadings.dart';
import 'package:newsapp/Screens/WebviewScreen.dart';
import 'package:newsapp/Screens/categorywisescreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> navBarItem = [
      "Top News",
      "India",
      "World",
      "Finance",
      "Health"
    ];
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    String randomgen() {
      List randomSearchNames = ["Health", 'country', 'company', 'finance'];
      Random randomname = Random();
      String randomsearch =
          randomSearchNames[randomname.nextInt(randomSearchNames.length)];

      return randomsearch.toString();
    }

    // Future getNewsByQuery(String query) async {
    //   String url =
    //       "https://newsapi.org/v2/everything?q=Apple&from=2024-07-25&sortBy=popularity&apiKey=cab885c685f84fa48b6ccf488f6c425e";
    //   https.Response response = await https.get(Uri.parse(url)); //Getting Http Response;
    //   Map data = jsonDecode(response.body); //Collecting jsonDecoded data and Storing As Map;
    //   setState(() {
    //     data['articles'].forEach((element) {  //applying a loop for each element in articles from API data
    //       NewsQueryModel newsmodel = NewsQueryModel(); // Instance of query Model
    //       newsmodel = NewsQueryModel.fromMap(element); //Mapping every element of Data to the QueryModel Created
    //       newsModelList.add(newsmodel); //Passing the Map data of Model to List.
    //       return data;
    //       setState(() {
    //         isLoading = false;
    //       });
    //     });
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Arne News"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                // textInputAction: TextInputAction.search,
                controller: searchcontroller,
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 1.2, color: Colors.teal)),
                    focusColor: Colors.white,
                    contentPadding: EdgeInsets.all(height * 0.01),
                    hintText: "Search ${randomgen()}",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.blue,
                    )),
                onFieldSubmitted: (value) {
                  print(searchcontroller.text);
                },
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                height: height * 0.055,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: navBarItem.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryScreen(
                                        categoryTitle: navBarItem[index])));
                            print(navBarItem[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 234, 238, 242),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black)),
                            height: height * 0.05,
                            width: width * 0.3,
                            child: Center(
                                child: Text(
                              navBarItem[index].toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                height: height * 0.25,
                child: FutureBuilder(
                    future: getTopNews(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(child: CircularProgressIndicator()));
                      } else {
                        return CarouselSlider.builder(
                            itemCount: snapshot.data!.articles!.length,
                            itemBuilder: (context, index, realIndex) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WebViewScreen(
                                                      heading: snapshot
                                                          .data!
                                                          .articles![index]
                                                          .title
                                                          .toString(),
                                                      url: snapshot.data!
                                                          .articles![index].url
                                                          .toString())));
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WebViewScreen(
                                                        heading:
                                                            snapshot
                                                                .data!
                                                                .articles![
                                                                    index]
                                                                .title
                                                                .toString(),
                                                        url: snapshot
                                                            .data!
                                                            .articles![index]
                                                            .url
                                                            .toString())));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: snapshot
                                                          .data!
                                                          .articles![index]
                                                          .urlToImage !=
                                                      null
                                                  ? Image.network(snapshot
                                                      .data!
                                                      .articles![index]
                                                      .urlToImage
                                                      .toString())
                                                  : Image.asset(
                                                      'assets/images/download.jpg',
                                                      fit: BoxFit.fill,
                                                      height: height,
                                                      width: width,
                                                    ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              child: Container(
                                                width: width * 0.73,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .bottomCenter,
                                                        end:
                                                            Alignment.topCenter,
                                                        colors: [
                                                          Colors.black,
                                                          Colors.black
                                                              .withOpacity(0.2)
                                                        ])),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      snapshot
                                                                  .data!
                                                                  .articles![
                                                                      index]
                                                                  .title !=
                                                              null
                                                          ? Text(
                                                              snapshot
                                                                  .data!
                                                                  .articles![
                                                                      index]
                                                                  .title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text(
                                                              "News Headline",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                      snapshot
                                                                  .data!
                                                                  .articles![
                                                                      index]
                                                                  .description !=
                                                              null
                                                          ? Text(
                                                              snapshot
                                                                          .data!
                                                                          .articles![
                                                                              index]
                                                                          .description!
                                                                          .length >
                                                                      20
                                                                  ? snapshot
                                                                      .data!
                                                                      .articles![
                                                                          index]
                                                                      .toString()
                                                                      .substring(
                                                                          0, 20)
                                                                  : snapshot
                                                                      .data!
                                                                      .articles![
                                                                          index]
                                                                      .description
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text(
                                                              "Description",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            },
                            options: CarouselOptions(
                                autoPlayAnimationDuration: Duration(seconds: 1),
                                autoPlayInterval: Duration(seconds: 4),
                                enlargeCenterPage: true,
                                enlargeFactor: 0.18,
                                autoPlay: true,
                                enableInfiniteScroll: true,
                                height: height * 0.28));
                      }
                    }),
              ),
              Column(
                children: [
                  Divider(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Latest News",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FutureBuilder(
                      future: searchcontroller.text.isNotEmpty
                          ? getNewsByQuery(searchcontroller.text.toString())
                          : getNewsByQuery(randomgen()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
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
                                                heading: snapshot.data!
                                                    .articles![index].title
                                                    .toString(),
                                                url: snapshot
                                                    .data!.articles![index].url
                                                    .toString())));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 15,
                                    shadowColor: const Color.fromARGB(
                                        255, 216, 228, 239),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          width: double.maxFinite,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: snapshot
                                                          .data!
                                                          .articles![index]
                                                          .urlToImage !=
                                                      null
                                                  ? Image.network(snapshot
                                                      .data!
                                                      .articles![index]
                                                      .urlToImage
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
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.black,
                                                      Colors.black
                                                          .withOpacity(0.2)
                                                    ])),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  snapshot
                                                              .data!
                                                              .articles![index]
                                                              .title !=
                                                          null
                                                      ? Text(
                                                          snapshot
                                                              .data!
                                                              .articles![index]
                                                              .title
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : Text(
                                                          "No Title Available"),
                                                  snapshot
                                                              .data!
                                                              .articles![index]
                                                              .description !=
                                                          null
                                                      ? Text(
                                                          snapshot
                                                                      .data!
                                                                      .articles![
                                                                          index]
                                                                      .description!
                                                                      .length >
                                                                  40
                                                              ? snapshot
                                                                  .data!
                                                                  .articles![
                                                                      index]
                                                                  .description
                                                                  .toString()
                                                                  .substring(
                                                                      0, 30)
                                                              : snapshot
                                                                  .data!
                                                                  .articles![
                                                                      index]
                                                                  .description
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      : Text(
                                                          "No Description Available")
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      }),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
