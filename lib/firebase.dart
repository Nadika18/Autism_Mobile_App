import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Widget _buildListViewItem(
    BuildContext context, index, List<QueryDocumentSnapshot> document) {
  return ListTile(
    title: Row(
      children: [
        Expanded(
            child: Text(document[index]['name'],
                style: Theme.of(context).textTheme.headline5)),
        Container(
            decoration: const BoxDecoration(
              color: Colors.white30,
            ),
            padding: const EdgeInsets.all(10),
            child: Text(document[index]['registration_code'].toString(),
                style: Theme.of(context).textTheme.headline6)),
      ],
    ),
  );
}

Widget getDataFromFirebase() {
  return FutureBuilder(
    future: getData(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return ListView.builder(
          itemExtent: 80,
          itemCount: snapshot.data.size,
          itemBuilder: (context, index) {
            return _buildListViewItem(context, index, snapshot.data.docs);
          },
        );
      } else if (snapshot.connectionState == ConnectionState.none) {
        return const Text('No data found');
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}

Future<QuerySnapshot> getData() async {
  await Firebase.initializeApp();
  return await FirebaseFirestore.instance.collection("parents").get();
}
