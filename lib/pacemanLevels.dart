import 'package:flutter/material.dart';

import 'level 2.dart';
import 'level 3 .dart';
import 'level1.dart';





class pacemanLevels extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()
            {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>level1()));
            },
            child: Text(
              'Level 1',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: ()
            {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>level2()));
            },
            child: Center(
              child: Text(
                'Level 2',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: ()
            {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>level3()));
            },
            child: Center(
              child: Text(
                'Level 3',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
