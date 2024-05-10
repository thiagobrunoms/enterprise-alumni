class ProductsList {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductsList({this.products, this.total, this.skip, this.limit});

  ProductsList.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = (json['products'] as List)
          .map((eachProduct) => Product.fromJson(eachProduct))
          .toList();
    }

    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
}

class Product {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  num? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }
}
