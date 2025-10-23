import 'package:disleksi_surum/models/users_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
class UserGetViewModel extends ChangeNotifier {
  Future<Users?> getUser() async {
    // Firebase Auth'tan mevcut kullanıcıyı al
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return null; // Giriş yoksa null döndür

    // UID ile Firestore'dan kullanıcı verisini al
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    // Eğer doküman varsa Users nesnesine çevir ve döndür
    if (doc.exists && doc.data() != null) {
      return Users.fromMap(doc.data()!, doc.id);
    }

    return null; // Kullanıcı dokümanı yoksa null
  }
}
