import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

displaymovieCard({
  double height = 200.0,
  width = 160.0,
  borderRadius = 10.0,
  Color color = Colors.white,
  String? image,
  moviename,
}) {
  final loadingWidget = Container(
    alignment: Alignment.center,
    height: height,
    child: const CupertinoActivityIndicator(),
  );

  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Image.network(
                    image,
                    height: height,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return loadingWidget;
                      }
                      return child;
                    },
                  ),
                )
              : loadingWidget,
          Positioned(
            bottom: 20,
            left: 20,
            child: moviename != null
                ? Text(
                    " $moviename",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ));
}
