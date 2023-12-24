import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/features/user_page.dart';
import 'package:flutter_project_structure/models/userModel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> userModel = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: userModel.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print(userModel[index].id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UserPage(userTitle: userModel[index].title)),
                      );
                    },
                    child: Container(
                      height: 130,
                      decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      margin: const EdgeInsets.only(
                          bottom: 5, right: 10, left: 10, top: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "User id: ${userModel[index].userId}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Id: ${userModel[index].id}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Tittle: ${userModel[index].title}",
                            maxLines: 1,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Body: ${userModel[index].body}",
                            maxLines: 1,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<List<UserModel>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        userModel.add(UserModel.fromJson(index));
      }
      return userModel;
    } else {
      return userModel;
    }
  }
}
