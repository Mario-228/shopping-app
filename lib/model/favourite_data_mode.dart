class GetFavourite
{
  bool ? status;
  GetFavouriteData ? data;

  GetFavourite.fromJson(Map<String,dynamic>json)
  {
    status=json["status"];
    data=GetFavouriteData.fromJson(json["data"]);
  }
}

class GetFavouriteData
{
  int ? currentPage;
  List<Data> data=[];
  GetFavouriteData.fromJson(Map<String,dynamic>json)
  {
    currentPage=json["current_page"];
    json['data'].forEach((element) 
    {
      data.add(Data.fromJson(element));
    });
  }
}

class Data
{
  int ? favId;
  FavProductData?  product;
  Data.fromJson(Map<String,dynamic>json)
  {
    favId=json['id'];
    product=FavProductData.fromJson(json['product']);
  }
}

class FavProductData
{
  int ? productId;
  num ? price;
  num ? oldPrice;
  num ? discount;
  String ? image;
  String ? name;

  FavProductData.fromJson(Map<String,dynamic>json)
  {
    productId=json["id"];
    price=json["price"];
    oldPrice=json["old_price"];
    discount=json["discount"];
    image=json["image"];
    name=json["name"];
  }
}