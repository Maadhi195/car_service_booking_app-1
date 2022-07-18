class ReviewModel {
  final String id;
  final String shopId;
  final String userId;
  final double rating;

  ReviewModel({
    required this.id,
    required this.shopId,
    required this.userId,
    required this.rating,
  });

  factory ReviewModel.fromMap(String uid, Map<String, dynamic> map) {
    return ReviewModel(
      id: uid,
      shopId: map['shopId'],
      userId: map['userId'],
      rating: map['rating'] ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'userId': userId,
      'rating': rating,
    };
  }
}
