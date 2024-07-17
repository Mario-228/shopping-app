class HomeModel
{
  bool ? status;
  HomeDataModel ? data;
  HomeModel.fromJson(Map<String,dynamic> json)
  {
    status=json["status"];
    data=HomeDataModel.fromJson(json["data"]);
  }
}

class HomeDataModel
{
  List<HomeBannersDataModel> banners=[];
  List<HomeProductsDataModel> products=[];
  HomeDataModel.fromJson(Map<String,dynamic> json)
  {
      json["banners"].forEach(
        (element){
          banners.add(HomeBannersDataModel.fromJson(element));
        });

      json["products"].forEach(
        (element){
          products.add(HomeProductsDataModel.fromJson(element));
        });
  }
}

class HomeBannersDataModel
{
  int ? id;
  String ? image;
  HomeBannersDataModel.fromJson(Map<String,dynamic> json)
  {
    id=json["id"];
    image=json["image"];
  }
}

class HomeProductsDataModel
{
  int ? id;
  num ? price;
  num ? oldPrice;
  num ? discount;
  String ? image;
  String ? name;
  bool ? inFavourites;
  bool ? inCart;

  HomeProductsDataModel.fromJson(Map<String,dynamic> json)
  {
    id=json["id"];
    price=json["price"];
    oldPrice=json["old_price"];
    discount=json["discount"];
    image=json["image"];
    name=json["name"];
    inFavourites=json["in_favorites"];
    inCart=json["in_cart"];
  }
}