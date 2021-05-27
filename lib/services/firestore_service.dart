import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/state/auth_state.dart';

class FirestoreServices {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> createChatRoom(uuid, data) async {
    return await db.collection('chatRooms').doc(uuid).set(data);
  }

  Future<void> updateChatrooms(context, uuid, data) async {
    var auth = Provider.of<Auth>(context, listen: false);
    if (auth.authenticated) {
      return await db.collection('chatRooms').doc(uuid).update({
        'isRead': false,
        'name': auth.authenticatedUser.userNicename,
        'userAvatal': auth.authenticatedUser.avatar,
        'gmail': auth.authenticatedUser.userEmail,
        "chat": FieldValue.arrayUnion(data)
      });
    } else {
      return await db
          .collection('chatRooms')
          .doc(uuid)
          .update({'isRead': false, "chat": FieldValue.arrayUnion(data)});
    }
  }

  Future<Map<String, dynamic>> readFromHome() async {
    DocumentSnapshot documentSnapshot =
        await db.collection('home').doc('1.1').get();
    return documentSnapshot.data();
  }

  Future<bool> addToFavorith(uuid, data) async {
    var status;
    await db.collection('favorites').doc(uuid).set(data).then((doc) {
      status= true;
    }).timeout(Duration(seconds:10)).catchError((error) {
      status= false;
    });
    return status;
  }

  Future<bool> updateFavorith(uuid, data) async {
    var status;
      await db.collection('favorites').doc(uuid)
          .update({"favorite": FieldValue.arrayUnion(data)  }).then((docs){
             status= true;
          }).timeout(Duration(seconds:10)).catchError((error) {
            status= false;
          });
    return status;
  }

  Future<bool> removeFavorith(uuid,data) async {
    var status;
      await db.collection('favorites').doc(uuid)
          .update({"favorite": FieldValue.arrayRemove(data)}).then((docs){
             status= true;
          }).timeout(Duration(seconds:10)).catchError((error) {
            status= false;
          });
    return status;
  }
  Future<Map<String, dynamic>> readFromFavorite(String uuid) async {
    DocumentSnapshot documentSnapshot =
        await db.collection('favorites').doc(uuid).get();
    return documentSnapshot.data();
  }
}
