class CategorirsModel{
  late bool status;
  late CategoriesDataModel categoriesDataModel;
  CategorirsModel.fromjson(Map<String, dynamic> json){
    status = json['status'];
    categoriesDataModel = CategoriesDataModel.fromjson(json['data']);
  }


}
class CategoriesDataModel{
  late int currentPage;
  late List<DataModel> data = [];
  CategoriesDataModel.fromjson(Map<String ,dynamic>json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromjson(element));
    }
    );}
}
class DataModel{
  late int id;
  late String name;
  late String image;

  DataModel.fromjson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

