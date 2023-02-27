import 'dart:io';
import 'dart:math';
import 'package:baskakov_app/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:baskakov_app/common/fetch_http_news.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:baskakov_app/screens/full_news_screen.dart';

const url = "https://www.cybersport.ru/rss/materials";
//https://movieweb.com/feed/
// https://www.oregonmetro.gov/news.xml
// const url = "https://www.finam.ru/analysis/conews/rsspoint/";


class HomeScreenRSS extends StatefulWidget {
  @override
  _HomeScreenRSSState createState() => _HomeScreenRSSState();
}

class _HomeScreenRSSState extends State {
  final List _newsList = [];

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.pink[200],
        appBar: AppBar(
          title: const Text('RSS-парсер БДС'),
        ),
        body: FutureBuilder(
          future: _getHttpNews(),
          builder: (context, AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                    scrollDirection: Axis.vertical,
                    itemCount: _newsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          child: Column(
                            children: [
                              Text(
                                  '${_newsList[index].title}',
                                style: const TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),
                              ),
                              //ImageWidget(urlImage: 'https://www.hltv.org/img/static/openGraphHltvLogo.png'),
                              //ImageWidget(urlImage: ''),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                  '${parseDescriptionOfNews(_newsList[index].description)}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //Text(DateFormat('dd-MMMM').format(HttpDate.parse('${_newsList[index].pubDate}')
                                      Text('Тут должна быть дата'),
                                  FloatingActionButton.small(
                                    heroTag: null,
                                    onPressed: () => Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => FullNewsScreen(urlNews: '${_newsList[index].link}',)
                                    )),
                                    shape: const RoundedRectangleBorder(),
                                    backgroundColor: Colors.pink[200],

                                    child: const Icon(Icons.arrow_forward),

                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              );
            }
          },
        ),
      ),
    );
  }
  _getHttpNews() async {
    final response = await http.Client().get(Uri.parse(url));
    final rssFeed = RssFeed.parse(response.body);
    for (var element in rssFeed.items!) {
      _newsList.add(element);

    }
    return _newsList;
  }
 }

