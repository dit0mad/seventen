class ProductModel {
  String? artist;
  int? price;
  String? type;
  String? description;
  List? urls;

  ProductModel(
    this.artist,
    this.price,
    this.type,
    this.description,
    this.urls,
  );

  ProductModel.fromJson(
    Map<String, dynamic> prod,
  ) {
    artist = prod['artist'];
    price = prod['price'] ?? 0;
    type = prod["type"] ?? 'empty';
    description = prod["description"] ?? 'Empty';
    urls = prod["urls"] ?? [];
  }

  Map<String, dynamic> toJson() => {
        'artist': artist,
        'price': price,
        'type': type,
        'description': description,
        'urls': urls,
      };
}
