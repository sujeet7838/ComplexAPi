// To parse this JSON data, do
//
//     final comboCategoryModel = comboCategoryModelFromJson(jsonString);

import 'dart:convert';

ComboCategoryModel comboCategoryModelFromJson(String str) =>
    ComboCategoryModel.fromJson(json.decode(str));

String comboCategoryModelToJson(ComboCategoryModel data) =>
    json.encode(data.toJson());

class ComboCategoryModel {
  int status;
  String message;
  Data data;

  ComboCategoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ComboCategoryModel.fromJson(Map<String, dynamic> json) =>
      ComboCategoryModel(
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
  LunchCombo lunchCombo;
  DinnerCombo dinnerCombo;

  Data({
    required this.lunchCombo,
    required this.dinnerCombo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        lunchCombo: LunchCombo.fromJson(json["Lunch_Combo"]),
        dinnerCombo: DinnerCombo.fromJson(json["Dinner_Combo"]),
      );

  Map<String, dynamic> toJson() => {
        "Lunch_Combo": lunchCombo.toJson(),
        "Dinner_Combo": dinnerCombo.toJson(),
      };
}

class DinnerCombo {
  String id;
  String name;
  String price;
  String details;

  DinnerCombo({
    required this.id,
    required this.name,
    required this.price,
    required this.details,
  });

  factory DinnerCombo.fromJson(Map<String, dynamic> json) => DinnerCombo(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "details": details,
      };
}

class LunchCombo {
  String id;
  String name;
  String price;
  List<Detail> details;

  LunchCombo({
    required this.id,
    required this.name,
    required this.price,
    required this.details,
  });

  factory LunchCombo.fromJson(Map<String, dynamic> json) => LunchCombo(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  String productId;
  String productName;
  String productDescription;
  String productImage;
  List<ProductVariation> productVariation;

  Detail({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productImage,
    required this.productVariation,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        productId: json["product_id"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        productImage: json["product_image"],
        productVariation: List<ProductVariation>.from(
            json["product_variation"].map((x) => ProductVariation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_description": productDescription,
        "product_image": productImage,
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
