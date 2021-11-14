import 'package:flutter/material.dart';

import 'package:travel_admin/constants.dart';
import 'package:travel_admin/models/service_model.dart';
import 'package:travel_admin/widgets/cached_image.dart';

class ServiceTile extends StatefulWidget {
  final ServiceModel service;
  ServiceTile(this.service);
  @override
  _ServiceTileState createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.1,
      constraints: BoxConstraints(minHeight: 70),
      child: Column(
        children: [
          Expanded(
              child: Container(
                  child: Row(
            children: [
              Container(
                width: size.width * 0.25,
                child: widget.service.imageUrl != null
                    ? cachedImage(
                        widget.service.imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        widget.service.image,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      widget.service.name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.av_timer,
                        size: 12,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.service.status != null
                            ? widget.service.status
                            : 'Available',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                  Container(
                    child: Text(
                      '\$ ${widget.service.price.toStringAsFixed(2)}',
                      style: TextStyle(color: kPrimary),
                    ),
                  ),
                ],
              ))
            ],
          ))),
          Divider()
        ],
      ),
    );
  }
}
