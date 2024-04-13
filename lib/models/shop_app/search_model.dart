class SearchModel{
  late bool status ;
  late dynamic message;
  late SearchModelData? data;
  SearchModel.fromjson(Map<String,dynamic>json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SearchModelData.fromjson(json['data']) : null ;
  }

}
class SearchModelData{
  List<SearchProductData> data = [];
  SearchModelData.fromjson(Map<String,dynamic>json){

    json['data'].forEach((element){
      data.add(SearchProductData.fromjson(element));
    });
  }
}

class SearchProductData{

  late int id;
  late dynamic price;
  late String image;
  late String name;
  late String description;
  late bool inFavourites;
  late bool inCart;

  SearchProductData.fromjson(Map<String ,dynamic> json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}