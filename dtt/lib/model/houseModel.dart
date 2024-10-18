
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
    "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
  };
}

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }