import 'package:shopping_app/model/favourite_model.dart';
import 'package:shopping_app/model/home_model.dart';
import 'package:shopping_app/model/login_model.dart';

abstract class ShoppingStates {}

class ShoppingInitialState extends ShoppingStates{}

class ShoppingChangeBottomState extends ShoppingStates{}

class ShoppingChangeOnboardingState extends ShoppingStates{}

class ShoppingChangeFormState extends ShoppingStates{}

class ShoppingIntialDioState extends ShoppingStates{}

class ShoppingLoginLoadingState extends ShoppingStates{}

class ShoppingLoginSuccessState extends ShoppingStates{
  LoginModel model;
  ShoppingLoginSuccessState(this.model);
}

class ShoppingLoginErrorState extends ShoppingStates{
  final String error;
  ShoppingLoginErrorState(this.error);
}

class ShoppingHomeLoadingState extends ShoppingStates{}

class ShoppingHomeSuccessState extends ShoppingStates{
  HomeModel ? model;
  ShoppingHomeSuccessState(this.model);
}

class ShoppingHomeErrorState extends ShoppingStates{
  final String error;
  ShoppingHomeErrorState(this.error);
}

class ShoppingCategorySuccessState extends ShoppingStates{}

class ShoppingCategoryErrorState extends ShoppingStates{}

class ShoppingFavouriteChangeState extends ShoppingStates{}

class ShoppingFavouriteSuccessState extends ShoppingStates{
  final FavouritesModel model;

  ShoppingFavouriteSuccessState(this.model);
  
}

class ShoppingFavouriteErrorState extends ShoppingStates{}

class ShoppingGetFavouriteSuccessState extends ShoppingStates{}

class ShoppingGetFavouriteErrorState extends ShoppingStates{}

class ShoppingGetFavouriteLoadingState extends ShoppingStates{}

class ShoppingGetProfileSuccessState extends ShoppingStates{}

class ShoppingGetProfileErrorState extends ShoppingStates{}

class ShoppingGetProfileLoadingState extends ShoppingStates{}

class ShoppingUpdateSuccessState extends ShoppingStates{}

class ShoppingUpdateErrorState extends ShoppingStates{}

class ShoppingUpdateLoadingState extends ShoppingStates{}

class ShoppingRegisterLoadingState extends ShoppingStates{}
class ShoppingRegisterSuccessState extends ShoppingStates{

  LoginModel model;
  ShoppingRegisterSuccessState(this.model);
}

class ShoppingRegisterErrorState extends ShoppingStates{
  final String error;
  ShoppingRegisterErrorState(this.error);
}
class ShoppingSearchSuccessState extends ShoppingStates{}

class ShoppingSearchErrorState extends ShoppingStates{}

class ShoppingSearchLoadingState extends ShoppingStates{}