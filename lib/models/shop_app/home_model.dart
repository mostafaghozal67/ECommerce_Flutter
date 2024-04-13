import 'dart:convert';

class HomeModel{
  late bool status;
  late HomelDataModel data;

  HomeModel.fromjson(Map<String ,dynamic> json){
    status = json['status'];
    data = HomelDataModel.fromjson(json['data']);
  }


}
class HomelDataModel{
  late List<BannerModel> banners = [] ;
  late List<ProductModel> products = [];

  HomelDataModel.fromjson(Map<String ,dynamic> json){
    json['banners'].forEach((element){ 
      banners.add(BannerModel.fromjson(element));
    });
    json['products'].forEach((elment){
      products.add(ProductModel.fromjson(elment));
    });
  }

}

class BannerModel{
  late int id ;
  late String image;

  BannerModel.fromjson(Map<String , dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel{
  late int id ;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  late String image;
  late String name;
  late bool inFavourites;
  late bool inCart;

  ProductModel.fromjson(Map<String , dynamic> json){
    id = json['id'];
    price = json['price'];
    oldprice = json['old_price'];
    discount= json['discount'];
    image = json['image'];
    name = json['name'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];

  }

}
