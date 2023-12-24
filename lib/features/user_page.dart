import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/models/userDetailsModels.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  const UserPage({super.key, required, this.userTitle});
  final userTitle;
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<UserDetailsModel> userDetailsModel = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserDetailsData(),
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: userDetailsModel.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(index, 'ID: ',
                            userDetailsModel[index].id.toString()),
                        getText(index, 'Name: ',
                            userDetailsModel[index].name.toString()),
                        getText(index, 'phone: ',
                            userDetailsModel[index].phone.toString()),
                        getText(index, 'Comapny Name: ',
                            userDetailsModel[index].company.name.toString()),
                        getText(index, 'email: ',
                            userDetailsModel[index].email.toString()),
                        getText(index, 'Address: ',
                            '${userDetailsModel[index].address.suite.toString()},${userDetailsModel[index].address.street.toString()},${userDetailsModel[index].address.city.toString()},${userDetailsModel[index].address.zipcode.toString()} '),
                        getText(index, 'Geo Location: ',
                            '${userDetailsModel[index].address.geo.lat.toString()}, ${userDetailsModel[index].address.geo.lng.toString()}'),
                      ],
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

  Future<List<UserDetailsModel>> getUserDetailsData() async {
    final responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        userDetailsModel.add(UserDetailsModel.fromJson(index));
      }
      return userDetailsModel;
    } else {
      return userDetailsModel;
    }
  }

  Text getText(int index, String fieldName, String content) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: fieldName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: content,
            style: const TextStyle(fontSize: 14),
          ),
          //TextSpan(text: ' world!'),
        ],
      ),
    );
  }
}
