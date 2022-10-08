import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController authorEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();

  addUser()async{
    await FirebaseFirestore.instance.collection('books').add(
        {
          'title': titleEditingController.text,
          'author': authorEditingController.text,
          'date': int.parse(dateEditingController.text),
        }
    );
    titleEditingController.clear();
    dateEditingController.clear();
    authorEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            TextField(
              controller: titleEditingController,
              decoration: const InputDecoration(labelText: 'タイトル', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: authorEditingController,
              decoration: const InputDecoration(labelText: '著者', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: dateEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '出版年', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: addUser,
              child: const Text('追加'),
            ),
          ],
        ),
      ),
    );
  }
}