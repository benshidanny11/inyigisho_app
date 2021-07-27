import 'package:flutter/material.dart';

class PostComment extends StatefulWidget {
  const PostComment({Key? key}) : super(key: key);

  @override
  _PostCommentState createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  @override
  Widget build(BuildContext context) {
    double screenHeigt = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeigt * .5,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(0, -7), // shadow direction: bottom right
            )
          ]),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              "Add your comment",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "Your name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      width: 0.1,
                      style: BorderStyle.solid,
                      color: Colors.grey[100] as Color),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(10),
                fillColor: Colors.white),
                
          ),
          SizedBox(
            height: 20,
          ),
          Container(

            height: 5 * 30,
            width: double.infinity,
            
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Comment",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        width: 0.1,
                        style: BorderStyle.solid,
                        color: Colors.grey[100] as Color),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  ),
                  maxLines: 5,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton.icon(
            onPressed: () {},
            label: Text("Submit"),
            icon: Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
