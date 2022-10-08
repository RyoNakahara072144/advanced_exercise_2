import 'package:advanced_exercise_2/add_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advance Exercise 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream:  FirebaseFirestore.instance.collection('books').orderBy('date').snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  final data = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (context, index){
                          final doc = data.docs[index].data() as Map<String, dynamic>;
                          return BookCard(book: doc);
                        }
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator(),);
              }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AddBook())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({Key? key, required this.book}) : super(key: key);

  final Map<String, dynamic> book;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Card(
        child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Text(book['title'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Text(book['author'], style: const TextStyle(fontSize: 16, color: Color(0xff555555)),)
              ],
            )
        ),
      ),
    );
  }
}
