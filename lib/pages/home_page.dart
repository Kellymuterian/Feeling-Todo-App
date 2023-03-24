import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kelly_logistics/data/models/member.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Load Data"),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('users').get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var member = Member.fromMap(snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>);
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(getInitials(member.name!)),
                      ),
                      title: Text(member.name ?? ""),
                      subtitle: Text(member.email ?? ""),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  String getInitials(String name) {
    List<String> words = name.split(' ');
    String initials = '';
    for (String word in words) {
      initials += word[0];
    }
    return initials.toUpperCase();
  }
}
