import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/models/comboCategoryModel.dart';
import 'package:http/http.dart' as http;

class ComboCategory extends StatefulWidget {
  const ComboCategory({super.key});

  @override
  State<ComboCategory> createState() => _ComboCategoryState();
}

class _ComboCategoryState extends State<ComboCategory> {
  var newData;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ComboCategoryModel>(
        future: getComboData(),
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //lunch Combo
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      Text(
                        snapshort.data!.data.lunchCombo.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(snapshort.data!.data.lunchCombo.price),
                    ],
                  ),
                ),
                Container(
                  height: 350,
                  // padding: const EdgeInsets.all(8),
                  // margin:
                  //     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  // decoration: BoxDecoration(
                  //   color: Colors.lightBlue,
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  child: ListView.builder(
                      itemCount: snapshort.data!.data.lunchCombo.details.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(8),
                          // margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: NetworkImage(
                                      'https://click4technologies.com/design/t20/bollywood-restarant/${snapshort.data!.data.lunchCombo.details[index].productImage}',
                                    ),
                                    fit: BoxFit.cover,
                                    height: 80.0,
                                  ),
                                  Column(
                                    children: [
                                      Text(snapshort.data!.data.lunchCombo
                                          .details[index].productName
                                          .toString()),
                                      Text(snapshort.data!.data.lunchCombo
                                          .details[index].productDescription
                                          .toString()),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
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
                                      items: snapshort.data!.data.lunchCombo
                                          .details[index].productVariation
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
                ),
                //dinner

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      Text(
                        snapshort.data!.data.dinnerCombo.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(snapshort.data!.data.dinnerCombo.price),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  padding: const EdgeInsets.all(8),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                      itemCount:
                          snapshort.data!.data.dinnerCombo.details.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          color: Colors.grey,
                          child: const Column(
                            children: [
                              // Row(
                              //   children: [
                              //     Image(
                              //       image: NetworkImage(
                              //         'https://click4technologies.com/design/t20/bollywood-restarant/${snapshort.data!.data.dinnerCombo.details[index]}',
                              //       ),
                              //       fit: BoxFit.fill,
                              //       height: 100.0,
                              //     ),
                              //     Column(
                              //       children: [
                              //         Text(snapshort.data!.data.dinnerCombo
                              //             .details[index].productName
                              //             .toString()),
                              //         Text(snapshort.data!.data.lunchCombo
                              //             .details[index].productDescription
                              //             .toString()),
                              //       ],
                              //     )
                              //   ],
                              // ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<ComboCategoryModel> getComboData() async {
    final responce = await http.post(
        Uri.parse(
            'https://click4technologies.com/design/t20/bollywood-restarant/api/location_combo_menu'),
        body: {
          'store_id': '2',
        });

    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      return ComboCategoryModel.fromJson(data);
    } else {
      return comboCategoryModelFromJson(data);
    }
  }
}
