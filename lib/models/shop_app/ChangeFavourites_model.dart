class ChangeFavouritesModel{
  late bool status;
  late String message;
  ChangeFavouritesModel.fromjson(Map<String , dynamic>json){
    status = json['status'];
    message = json['message'];
  }
}