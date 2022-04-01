import 'package:flutter/material.dart';
import 'toilet_card.dart';

import '../models/toilet.dart';

class bottomPanel extends StatelessWidget {
  const bottomPanel({
    Key? key,
    required this.indices,
    required this.context,
    required List<Toilet> toiletList,
    required this.sc,
  })  : _toiletList = toiletList,
        super(key: key);

  final Map indices;
  final BuildContext context;
  final List<Toilet> _toiletList;
  final ScrollController sc;

  @override
  Widget build(BuildContext context) {
    final List<int> indexList = List<int>.generate(indices.length,
        (int indexPointer) => indices.keys.elementAt(indexPointer),
        growable: true);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
          Divider(
            thickness: 1.5,
            indent: 10,
            endIndent: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                child: Text("Recommended toilets in the area...",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.wc,
                size: 40,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
              physics: ScrollPhysics(),
              child: indexList.length == 0
                  ? Column(
                      children: [
                        Image.asset(
                          'lib/assets/no_toilets.png',
                          scale: 2,
                        ),
                        Text('Sorry dude, gotta shit your pants!',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(color: Colors.black),
                            textAlign: TextAlign.center),
                      ],
                    )
                  : ListView.builder(
                      itemCount: indexList.length <= 10 ? indexList.length : 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int indexPointer) {
                        return toiletCard(
                            indices: indices,
                            toiletList: _toiletList,
                            index: indexList[indexPointer],
                            sc: this.sc);
                      },
                    )),
        ],
      ),
    );
  }
}
