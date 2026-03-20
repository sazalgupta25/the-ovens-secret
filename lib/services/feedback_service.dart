import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/feedback_model.dart';

class FeedbackService {
  final CollectionReference _feedbackCollection =
      FirebaseFirestore.instance.collection('customer_feedback');

  Future<void> submitFeedback(CustomerFeedback feedback) async {
    await _feedbackCollection.add(feedback.toJson());
  }

  Stream<List<CustomerFeedback>> getFeedbackStream() {
    return _feedbackCollection
        .orderBy('date', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return CustomerFeedback.fromJson(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
