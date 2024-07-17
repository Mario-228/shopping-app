class CategoriesData
{
  bool ? status;
  DataModel ? data;
  CategoriesData.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    data=DataModel.fromJson(json['data']);
  }
}

class DataModel
{
  int ? currentPage;
  List<DataInfo> data=[];
  DataModel.fromJson(Map<String,dynamic> json)
  {
    currentPage=json["current_page"];
    json["data"].forEach((element){
      data.add(DataInfo.fromJson(element));
    });
  }
}

class DataInfo
{
  int ? id;
  String ? name;
  String ? image;

  DataInfo.fromJson(Map<String,dynamic> json)
  {
    id=json["id"];
    name=json["name"];
    image=json["image"];
  }
}