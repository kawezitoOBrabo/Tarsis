import 'package:flutter/material.dart';

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
              backgroundColor: Colors.grey.shade300,
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
                      isFavorited = !isFavorited;
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
                  isBookmarked = !isBookmarked;
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
