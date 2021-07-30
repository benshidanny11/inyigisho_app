import 'package:flutter/material.dart';

class PostComment extends StatefulWidget {
  final Function handleAddComment;
  final int lessId;
  const PostComment(
      {required this.handleAddComment, required this.lessId, Key? key})
      : super(key: key);

  @override
  _PostCommentState createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  final nameController = TextEditingController();
  final commentController = TextEditingController();
  bool showLoading = false;

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
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey[300] as Color, width: 0.7),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 0.7),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.white),
              controller: nameController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 5 * 20,
            width: double.infinity,
            child: TextField(
                decoration: InputDecoration(
                  labelText: "Comment",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey[300] as Color, width: 0.7),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 0.7),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.all(10),
                  fillColor: Colors.white,
                ),
                maxLines: 5,
                controller: commentController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton.icon(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (nameController.text.isEmpty ||
                  commentController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Please fill blank space!"),
                ));
              } else {
                widget.handleAddComment(context, nameController.text,
                    commentController.text, widget.lessId);
                setState(() {
                  showLoading = true;
                });
              }
            },
            label: Text("Submit"),
            icon: Icon(Icons.send),
          ),
          SizedBox(
            height: 5,
          ),
          showLoading
              ? SizedBox(
                  child: CircularProgressIndicator(),
                  height: 15.0,
                  width: 15.0,
                )
              : Text("")
        ],
      ),
    );
  }
}
