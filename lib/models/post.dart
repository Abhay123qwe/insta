import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String userName;
  final String postUrl;
  // ignore: prefer_typing_uninitialized_variables
  final datePublished;
  final String profImage;
  // ignore: prefer_typing_uninitialized_variables
  final likes;

  Post(
      {required this.description,
      required this.uid,
      required this.postId,
      required this.userName,
      required this.postUrl,
      required this.datePublished,
      required this.profImage,
      this.likes});

  Map<String, dynamic> toJson() => {
        "username": userName,
        "uid": uid,
        "description": description,
        "postUrl": postUrl,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profImage,
        'likes': likes
      };

  static Post fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot['description'],
        postId: snapshot['postId'],
        uid: snapshot['uid'],
        postUrl: snapshot['postUrl'],
        likes: snapshot['likes'],
        datePublished: snapshot['datePublished'],
        profImage: snapshot['profImage'],
        userName: snapshot['username']);
  }
}
