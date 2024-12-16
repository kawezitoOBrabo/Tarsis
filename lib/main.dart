import 'package:flutter/material.dart';
import 'Pesquisa.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReCycleScreen(),
    );
  }
}

class ReCycleScreen extends StatelessWidget {
  final List<Map<String, String>> posts = [
    {
      'username': 'Usuário',
      'imageUrl': 'https://i.pinimg.com/564x/de/dd/3d/dedd3d8f3ec58659e569f95cbdcb027f.jpg', 
      'description': 'Descrição do item aqui.',
   },
    {
      'username': 'Usuário_02',
      'imageUrl': 'https://i.pinimg.com/474x/68/c5/88/68c588d14faf7b3f3b3944b5c5acbaf8.jpg', 
      'description': 'Descrição do item aqui.',
    },
    {
      'username': 'Usuário_03',
      'imageUrl': 'https://i.pinimg.com/236x/0c/96/bb/0c96bbe90a93e6af096fd8917e0295ca.jpg',
      'description': 'Descrição do item aqui.',
    },
    {
      'username': 'Usuário_04',
      'imageUrl': 'https://i.pinimg.com/564x/b1/73/70/b17370f53396ec47060da0acaea7a76c.jpg', 
      'description': 'Descrição do item aqui.',
    },
    {
      'username': 'Usuário_05',
      'imageUrl': 'https://i.pinimg.com/236x/8d/a2/18/8da218c3b0eeed99f65c1787d69faf55.jpg',
      'description': 'Descrição do item aqui.',
    },
    {
      'username': 'Usuário_06',
      'imageUrl': 'https://i.pinimg.com/736x/42/f3/0f/42f30f363b8b175ddb5acff940f153cf.jpg', 
      'description': 'Descrição do item aqui.',
    },
    {
      'username': 'Usuário_07',
      'imageUrl': 'https://i.pinimg.com/236x/87/3d/af/873daf89360c06ee2c469fcbfb647251.jpg', 
      'description': 'Descrição do item aqui.',
    },
    
  ];

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
              style: TextStyle(color: const Color.fromARGB(255, 60, 127, 62),),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.map, color: const Color.fromARGB(255, 60, 127, 62),), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.handshake_outlined, color: const Color.fromARGB(255, 60, 127, 62)), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.search, color: const Color.fromARGB(255, 60, 127, 62)),
                onPressed: () {
                   Navigator.push(
                     context,
                       MaterialPageRoute(builder: (context) => HomeScreen()),
                );
               }),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(6),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              PostItem(
                imageUrl: posts[index]['imageUrl']!,
                username: posts[index]['username']!,
                description: posts[index]['description']!,
              ),   
              
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green.shade100,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: const Color.fromARGB(255, 60, 127, 62),), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add, color: const Color.fromARGB(255, 60, 127, 62),), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_rounded, color: const Color.fromARGB(255, 60, 127, 62),), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message, color: const Color.fromARGB(255, 60, 127, 62),), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle, color: const Color.fromARGB(255, 60, 127, 62),), label: ''),
       
        ],
      ),
    );
  }
}

class PostItem extends StatefulWidget {
  final String imageUrl;
  final String username;
  final String description;

  PostItem({
    required this.imageUrl,
    required this.username,
    required this.description,
  });

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isFavorited = false; 
  bool isBookmarked = false; 

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
         children: [
         Row(
          children: [
            CircleAvatar(
               backgroundColor: Colors.grey.shade300
               ,
                 child: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(width: 8),
              Text(widget.username,
                 style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 8),
        Image.network(
          widget.imageUrl,
            height: 200,
              width: double.infinity,
                fit: BoxFit.cover,
        ),
        SizedBox(height: 8),
        Text(widget.description),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited
                        ? Colors.red
                        : const Color.fromARGB(162, 23, 142, 54),
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorited =
                        !isFavorited; 
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chat_bubble_outline),
                    onPressed: () {},
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked
                    ? const Color.fromARGB(255, 11, 125, 20)
                    : Color.fromARGB(162, 23, 142, 54),
              ),
              onPressed: () {
                setState(() {
                  isBookmarked =
                    !isBookmarked; 
                });
              },
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
