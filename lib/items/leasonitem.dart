import 'package:flutter/material.dart';
import 'package:inyigisho_app/constants/routes.dart';
import 'package:inyigisho_app/models/Leason.dart';

class LeasonItem extends StatelessWidget {
  final Leason leason;

  const LeasonItem(this.leason);

  void _handleItemClick(BuildContext context) {
    Navigator.of(context)
        .pushNamed(RouteConstants.LeasonDetailsRoute, arguments: leason.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleItemClick(context);
      },
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(leason.featureImageUrl),
                          ),
                        )),
                    Positioned(
                        bottom: 2,
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(5),
                          color: Colors.black38,
                          child: Text(
                            'By ${leason.posterName}',
                            style: TextStyle(color: Colors.white, fontSize: 9),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                  ]),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        leason.title.toUpperCase(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        leason.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  )),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Text(
                            leason.doneOn,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 11),
                          ))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
