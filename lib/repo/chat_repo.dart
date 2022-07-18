import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatRepo {
  static final ChatRepo instance = ChatRepo();

  static final CollectionReference collection =
      FirebaseFirestore.instance.collection('chat');

  //get messages from firebase chat collection via stream
  Stream<List<types.Message>> getMessages() {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return types.Message.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //add message to firebase collection
  Future<void> addMessage(types.Message message) async {
    await collection.doc(message.id).set(message.toJson());
  }
}
