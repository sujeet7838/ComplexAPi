// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  int status;
  String message;
  Data data;

  CategoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  List<MainCourse> mainCourse;
  List<MainCourse> starter;

  Data({
    required this.mainCourse,
    required this.starter,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mainCourse: List<MainCourse>.from(
            json["Main_Course"].map((x) => MainCourse.fromJson(x))),
        starter: List<MainCourse>.from(
            json["Starter"].map((x) => MainCourse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Main_Course": List<dynamic>.from(mainCourse.map((x) => x.toJson())),
        "Starter": List<dynamic>.from(starter.map((x) => x.toJson())),
      };
}

class MainCourse {
  String productId;
  String productName;
  String categoryId;
  String categoryName;
  String productDescription;
  String productImage;
  String productPrice;
  List<ProductVariation> productVariation;

  MainCourse({
    required this.productId,
    required this.productName,
    required this.categoryId,
    required this.categoryName,
    required this.productDescription,
    required this.productImage,
    required this.productPrice,
    required this.productVariation,
  });

  factory MainCourse.fromJson(Map<String, dynamic> json) => MainCourse(
        productId: json["product_id"],
        productName: json["product_name"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        productDescription: json["product_description"],
        productImage: json["product_image"],
        productPrice: json["product_price"],
        productVariation: List<ProductVariation>.from(
            json["product_variation"].map((x) => ProductVariation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "category_id": categoryId,
        "category_name": categoryName,
        "product_description": productDescription,
        "product_image": productImage,
        "product_price": productPrice,
        "product_variation":
            List<dynamic>.from(productVariation.map((x) => x.toJson())),
      };
}

class ProductVariation {
  String variationType;
  String variationValueId;
  String variationValueName;

  ProductVariation({
    required this.variationType,
    required this.variationValueId,
    required this.variationValueName,
  });

  factory ProductVariation.fromJson(Map<String, dynamic> json) =>
      ProductVariation(
        variationType: json["variation_type"],
        variationValueId: json["variation_value_id"],
        variationValueName: json["variation_value_name"],
      );

  Map<String, dynamic> toJson() => {
        "variation_type": variationType,
        "variation_value_id": variationValueId,
        "variation_value_name": variationValueName,
      };
}
