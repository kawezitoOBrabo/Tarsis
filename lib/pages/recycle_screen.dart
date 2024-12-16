import 'package:Tarsis/pages/video_player_pageView.dart';
import 'package:flutter/material.dart';
import 'package:Tarsis/db/post_database.dart';
import 'package:Tarsis/widget/post_item.dart';
import 'package:Tarsis/pages/recommended.dart';

class ReCycleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Row(
          children: [
            Icon(Icons.eco, color: Colors.green),
            SizedBox(width: 8),
            Text(
              'ReCycle',
              style: TextStyle(
                color: const Color.fromARGB(255, 60, 127, 62),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon:
                Icon(Icons.map, color: const Color.fromARGB(255, 60, 127, 62)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.handshake_outlined,
                color: const Color.fromARGB(255, 60, 127, 62)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search,
                color: const Color.fromARGB(255, 60, 127, 62)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(6),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostItem(
            imageUrl: posts[index]['imageUrl']!,
            username: posts[index]['username']!,
            description: posts[index]['description']!,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green.shade100,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: const Color.fromARGB(255, 60, 127, 62)),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.add,
                  color: const Color.fromARGB(255, 60, 127, 62)),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(
                  Icons.play_circle_rounded,
                  color: const Color.fromARGB(255, 60, 127, 62),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageViewScreen(),
                    ),
                  );
                },
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.message,
                  color: const Color.fromARGB(255, 60, 127, 62)),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,
                  color: const Color.fromARGB(255, 60, 127, 62)),
              label: ''),
        ],
      ),
    );
  }
}
