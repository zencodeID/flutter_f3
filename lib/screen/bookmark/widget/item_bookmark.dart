import 'package:submiss_f3/data/model/detail_restaurant.dart';
import 'package:submiss_f3/utils/resource/rescolor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget itemBookmark(
    BuildContext context, DetailRestaurant detail, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Text(
                    detail.name ?? "",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Hero(
                  tag: detail.pictureId ?? "",
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                    child: CachedNetworkImage(
                      imageUrl: detail.pictureId != null
                          ? "https://restaurant-api.dicoding.dev/images/medium/${detail.pictureId}"
                          : "",
                      placeholder: (context, url) => Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: ResColor.blue,
                          ),
                        ),
                      ),
                      errorWidget: (context, object, stackTrace) =>
                          Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
  );
}
