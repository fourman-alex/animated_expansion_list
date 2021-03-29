import 'package:flutter/material.dart';

import 'constants.dart';
import 'expand_list_tile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Tile Expansion Demo'),
      ),
      body: ListView(
        children: List<Widget>.generate(
          10,
          (index) => ExpandListTile(
            collapsedChild: ListTile(
              leading: Image.asset('assets/placeholder_image.png'),
              title: Text('Item $index Title'),
              subtitle: Text('Subtitle'),
            ),
            expandedChild: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/placeholder_image.png',
                    width: 32.2 * 4,
                    height: 29.4 * 4,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Flexible(
                    child: Text(
                      lorem_ipsum,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // children: [
        //   ExpandListTile(
        //     closedChild: ListTile(
        //       leading: Image.asset('assets/placeholder_image.png'),
        //       title: Text('Title'),
        //       subtitle: Text('Subtitle'),
        //     ),
        //     openChild: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         SizedBox(
        //             height: 70,
        //             child: Image.asset('assets/placeholder_image.png')),
        //         Flexible(
        //           child: Text(lorem_ipsum),
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
