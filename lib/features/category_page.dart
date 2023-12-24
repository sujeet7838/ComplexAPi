import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/models/categoryModel.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // List<CategoryModel> categoryModel = [];
  var newData;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CategoryModel>(
        future: getCategoryData(),
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            return Container(
              child: Column(
                children: [
                  ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      itemCount: snapshort.data!.data.mainCourse.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(snapshort
                                  .data!.data.mainCourse[index].productName
                                  .toString()),
                              Text(snapshort
                                  .data!.data.mainCourse[index].categoryName
                                  .toString()),
                              Text(snapshort
                                  .data!.data.mainCourse[index].productPrice
                                  .toString()),
                              Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: DropdownButton(
                                      value: newData,
                                      isDense: true,
                                      underline: Container(),
                                      hint: const Text('Select value'),
                                      isExpanded: true,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: snapshort.data!.data
                                          .mainCourse[index].productVariation
                                          .map((item) {
                                        return DropdownMenuItem(
                                          value:
                                              item.variationValueId.toString(),
                                          child: Text(item.variationValueName
                                              .toString()),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        newData = value;
                                        setState(() {});
                                      }))
                            ],
                          ),
                        );
                      }),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<CategoryModel> getCategoryData() async {
    final responce = await http.post(
        Uri.parse(
            'https://click4technologies.com/design/t20/bollywood-restarant/api/location_category_menu'),
        body: {
          'store_id': '2',
        });
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      return CategoryModel.fromJson(data);
    } else {
      return CategoryModel.fromJson(data);
    }
  }
}
