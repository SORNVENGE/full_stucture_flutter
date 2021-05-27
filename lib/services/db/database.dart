import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'database_event.dart';
import 'model.dart';

abstract class Database extends DatabaseEvent {
  String table;

  Query query;

  CollectionReference get collectionRef {
    return FirebaseFirestore.instance.collection(this.table);
  }

  Future<Collections> fetch() async {
    QuerySnapshot snapshot = await this.query.get();

    List<Model> models = snapshot.docs.map((doc) {
      Map data = this.toMap(doc.data());

      var thirdMap = {};
      thirdMap.addAll({"docId": doc.id});
      thirdMap.addAll(data);

      return super.onRead(Model(
        attribute: thirdMap,
        original: data,
        table: table,
      ));
    }).toList();

    return Collections(models);
  }

  Map toMap(Object object) {
    return json.decode(json.encode(object));
  }

  Future<List<dynamic>> getNotification(String uuid,) async {
    var notification = [];

    QuerySnapshot my = await FirebaseFirestore.instance.collection('notifications').where('uuid', isEqualTo: uuid).get();
    if(my.docs.length > 0){
      var myNews = my.docs.map((e) => e.data()).toList();
      notification.addAll(myNews);
    }

    QuerySnapshot public = await FirebaseFirestore.instance.collection('notifications').where('status', isEqualTo: 'public').get();
    if(public.docs.length > 0){
      var myNews = public.docs.map((e) => e.data());

      notification.addAll(myNews);
    }

    return notification;
  }

  Future<Collections> get() async {
    QuerySnapshot snapshot = await this.collectionRef.get();

    List<Model> models = snapshot.docs.map((doc) {
      Map data = this.toMap(doc.data());
      var merge = {};
      merge.addAll({"docId": doc.id});
      merge.addAll(data);

      return super.onRead(Model(
        attribute: merge,
        original: data,
        table: table,
      ));
    }).toList();

    return Collections(models);
  }

  arrayContains(dynamic field, {dynamic contains}) {
    this.query = this.collectionRef.where('catId', arrayContains: contains);
    return this;
  }

  Future<Collections> where(dynamic field, {dynamic isEqualTo}) async {
    QuerySnapshot snapshot =
        await this.collectionRef.where(field, isEqualTo: isEqualTo).get();

    List<Model> models = snapshot.docs
        .map((doc) => super.onRead(Model(
              // attribute: doc.data()..addAll({"docId": doc.id}),
              original: doc.data(),
              table: table,
            )))
        .toList();

    return Collections(models);
  }

  Widget foreach({Function builder, Function onLoading}) {
    return FutureBuilder(
        future: this.get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return onLoading();
          }

          return ListView.builder(
              itemCount: snapshot.data.count(),
              itemBuilder: (context, int index) {
                final item = snapshot.data.items[index];

                return builder(item);
              });
        });
  }

  Model fromMap(Map data) {
    return Model(attribute: {...data}, original: {...data}, table: table);
  }

  Future<Model> find(String id) async {
    DocumentReference reference = this.collectionRef.doc(id);

    DocumentSnapshot doc = await reference.get();
    var data = this.toMap(doc.data());
    var merge = {};
    merge.addAll({"docId": doc.id});
    merge.addAll(data);
    return super.onRead(Model(attribute: merge, original: data, table: table));
  }
}
