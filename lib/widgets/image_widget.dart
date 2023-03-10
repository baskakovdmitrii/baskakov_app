import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
 final String urlImage;
 final double height;
 final double width;

 const ImageWidget(
  {Key? key, required this.urlImage, this.height = 50, this.width = 80})
     : super(key: key);

 @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(3),
     child: CachedNetworkImage(
       placeholder: (context, url) => Image.asset('assets/noimage.jpg'),
       imageUrl: urlImage,
       height: 180,
       width: 300,
       alignment: Alignment.center,
       fit: BoxFit.fill,
     ),
    );
  }


}