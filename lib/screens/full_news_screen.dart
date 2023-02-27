import 'package:flutter/material.dart';
import 'package:baskakov_app/models/news_model.dart';
import 'package:baskakov_app/common/fetch_http_news.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
const url = "https://www.cybersport.ru/rss/materials";
class FullNewsScreen extends StatefulWidget {
  final urlNews;

  FullNewsScreen({@required this.urlNews});

  @override
  _FullNewsScreenState createState() => _FullNewsScreenState();
}

class _FullNewsScreenState extends State<FullNewsScreen> {
  var _newsModel = News(title: '', news_url: '', body: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _getNews()
    );

  }
  _getNews(){
    //return FutureBuilder(
     // future: _getHttpFullNews(),
     // builder: (context, AsyncSnapshot snapshot) {
        //if (!snapshot.hasData) {
        // return const Center(
        //  child: CircularProgressIndicator(),
        //  );
       // } else {
       //   return ListView(
       //     children: [
       //       Text('${_newsModel.title}'),
       //       Text('${_newsModel.body}')
       //     ],
       //   );
      //  }
     // },
   // );
    return FutureBuilder(
         future: _getHttpFullNews(),
         builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return ListView(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${_newsModel.title}',
                  style: const TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${_newsModel.body}',
                  style: const TextStyle(fontSize: 15.0 , fontWeight: FontWeight.bold),),
              ),
            ],
          );
         } else {
           return ListView(
             children: [
               Text('${_newsModel.title}',
                 style: const TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
               Text('${_newsModel.body}',
                 style: const TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
             ],
           );
          }
         },
    );
  }
  _getHttpFullNews() async {
    var response = await http.Client().get(Uri.parse(widget.urlNews));
    final _news = parse(response.body);
    _newsModel.title = _news.getElementsByTagName('h1')[0].text;
    _newsModel.body = _news.getElementsByClassName('text-content js-mediator-article js-mediator-article root_sK2zH content_5HuK5')[0].text;
    _newsModel.news_url = widget.urlNews;


    print('1');
    print(_news.getElementsByTagName('p')[0].text);
    print('2');
    print(_news.getElementsByClassName('text-content js-mediator-article js-mediator-article root_sK2zH content_5HuK5')[0].children[0].text);
  }
}

