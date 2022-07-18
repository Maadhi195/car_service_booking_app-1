import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/review_model.dart';

class ReviewRepo {
  static final ReviewRepo instance = ReviewRepo();

  static final CollectionReference collection =
      FirebaseFirestore.instance.collection('reviews');

  //add a new review
  Future<void> addReview(ReviewModel review) async {
    await collection.add(review.toMap());
  }
}
