class ProductModel {
  //String? id;
  String? artist;
  int? price;
  String? type;
  String? description;
  List? urls;
  //String? imageurl;

  ProductModel(
    // this.id,
    this.artist,
    this.price,
    this.type,
    this.description,
    this.urls,
  );

  ProductModel.fromJson(
    Map<String, dynamic> prod,

    // String this.id,
  ) {
    artist = prod['artist'];
    price = prod['price'] ?? 0;
    type = prod["type"] ?? 'empty';
    description = prod["description"] ?? 5;
    urls = prod["urls"] ?? [];
    // imageurl = prod["imageurl"] ?? 'www.google.com';
  }

  Map<String, dynamic> toJson() => {
        'artist': artist,
        'price': price,
        'type': type,
        'description': description,
        'urls': urls,
      };
}
