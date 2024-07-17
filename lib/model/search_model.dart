class SearchModel
{
  bool ? status;
  DataInfo ? data;

  SearchModel.fromJson(Map<String,dynamic>json)
  {
    status=json["status"];
    data=DataInfo.fromJson(json["data"]);
  }
}
class DataInfo
{
  int ? currentPage;
  List<DataDetails> data=[];

  DataInfo.fromJson(Map<String,dynamic>json)
  {
    currentPage=json["current_page"];
    json["data"].forEach(
      (element)
      {
        data.add(DataDetails.fromJson(element));
      });
  }
}

class DataDetails
{
  int ? id;
  num ? price;
  String ? image;
  String ? name;
  bool ? inFavourite;

  DataDetails.fromJson(Map<String,dynamic>json)
  {
    id=json["id"];
    price=json["price"];
    image=json["image"];
    name=json["name"];
    inFavourite=json["in_favorites"];
  }
}