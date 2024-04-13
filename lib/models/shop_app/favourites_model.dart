class FavoritesModel {
  late bool status;
  late Null message;
  late FavouritesDataModel? data1;

  FavoritesModel.fromjson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data1= json['data'] != null ? FavouritesDataModel.fromjson(json['data']) : null ;
  }
}

class FavouritesDataModel {
  late int currentPage;
  late List<FavoritesData> data2 = [];

  FavouritesDataModel.fromjson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data2.add(FavoritesData.fromJson(element));
    });

  }
}

class FavoritesData {
  late int id;
  late ProductData? product ;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // json['product'].forEach((element) {
    //   product.add(ProductData.fromJson(element));
    // });
    // if (json['data'] != null) {
    //   json['data'].forEach((element) {
    //     product=(ProductData.fromJson(element));
    //   });
    // }
    product = json['product']!= null ? ProductData.fromjson(json['product']) : null ;
  }
}
class ProductData {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;


  ProductData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];

  }

}


