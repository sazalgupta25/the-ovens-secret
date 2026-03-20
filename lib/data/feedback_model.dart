import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerFeedback {
  final String? id;
  final String author;
  final String quote;
  final DateTime date;
  final double rating;
  final String userId;

  CustomerFeedback({
    this.id,
    required this.author,
    required this.quote,
    required this.date,
    required this.userId,
    this.rating = 5.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'quote': quote,
      'date': Timestamp.fromDate(date),
      'rating': rating,
      'userId': userId,
    };
  }

  factory CustomerFeedback.fromJson(Map<String, dynamic> json, String id) {
    return CustomerFeedback(
      id: id,
      author: json['author'] ?? 'A Happy Customer',
      quote: json['quote'] ?? '',
      date: (json['date'] as Timestamp).toDate(),
      rating: (json['rating'] ?? 5.0).toDouble(),
      userId: json['userId'] ?? '',
    );
  }
}
