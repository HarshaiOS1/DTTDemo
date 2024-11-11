import 'package:intl/intl.dart';

class House {
  int id;
  String image;
  int price;
  int bedrooms;
  int bathrooms;
  int size;
  String description;
  String zip;
  String city;
  int latitude;
  int longitude;
  DateTime createdDate;

  House({
    required this.id,
    required this.image,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.size,
    required this.description,
    required this.zip,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.createdDate,
  });

  factory House.fromJson(Map<String, dynamic> json) => House(
    id: json["id"],
    image: json["image"],
    price: json["price"],
    bedrooms: json["bedrooms"],
    bathrooms: json["bathrooms"],
    size: json["size"],
    description: json["description"],
    zip: json["zip"],
    city: json["city"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdDate: DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "price": price,
    "bedrooms": bedrooms,
    "bathrooms": bathrooms,
    "size": size,
    "description": description,
    "zip": zip,
    "city": city,
    "latitude": latitude,
    "longitude": longitude,
    "createdDate": DateFormat('yyyy-MM-dd').format(createdDate),
  };
}