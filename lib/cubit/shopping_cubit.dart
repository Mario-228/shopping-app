import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubit/states.dart';
import 'package:shopping_app/dio/dio.dart';
import 'package:shopping_app/end_points.dart';
// import 'package:shopping_app/favourite.dart';
import 'package:shopping_app/model/categories.dart';
import 'package:shopping_app/model/favourite_data_mode.dart';
import 'package:shopping_app/model/favourite_model.dart';
import 'package:shopping_app/model/home_model.dart';
import 'package:shopping_app/model/login_model.dart';
import 'package:shopping_app/model/search_model.dart';
import 'package:shopping_app/reusable%20components/reusable_components.dart';

class ShoppingCubit extends Cubit<ShoppingStates>
{
  ShoppingCubit():super(ShoppingInitialState());

  static ShoppingCubit get(context) => BlocProvider.of(context); 

  int currentIndex=0;

  void changeBottom(int index)
  {
    currentIndex=index;
    emit(ShoppingChangeBottomState());
  }

  bool isFinal=false;

  void changeOnboarding(bool last)
  {
    isFinal=last;
    emit(ShoppingChangeOnboardingState());
  }
  bool isPassword=true;
  IconData password=Icons.visibility_off;
  void changeForm()
  {
    isPassword=!isPassword;
    if(isPassword)
    {
      password=Icons.visibility_off;
    }
    else
    {
      password=Icons.visibility;
    }
    emit(ShoppingChangeFormState());
  }
   LoginModel? model;
  void login(String email,String password)
  {
    emit(ShoppingLoginLoadingState());
    DioHelper.postData(path:loginData, data:{
      'email': email,
      'password':password,
    }).then((value){
      model=LoginModel.fromJson(value.data);
      emit(ShoppingLoginSuccessState(model!));
    }).catchError((error)
    {
      // print(error.toString());
      emit(ShoppingLoginErrorState(error.toString()));
    });
  }
  void intialDio()
  {
    DioHelper.initDio();
    emit(ShoppingIntialDioState());
  }

  HomeModel ? homeModel;
  Map<int?,bool?> favourite={};
  void getHomeData()
  {
    emit(ShoppingHomeLoadingState());

    DioHelper.getData(path: home,authorization: token).then((value) 
    {
      homeModel=HomeModel.fromJson(value.data);
      // ignore: avoid_function_literals_in_foreach_calls
      homeModel!.data!.products.forEach(
        (element) 
        {
          favourite.addAll({element.id:element.inFavourites});
        }
        );
      emit(ShoppingHomeSuccessState(homeModel));
    }).catchError((error){
      // print(error.toString());
      emit(ShoppingHomeErrorState(error.toString()));
    });
  }

  CategoriesData ? categoryData;
  void getCategoryData()
  {
    DioHelper.getData(path:categories).then((value) 
    {
      categoryData=CategoriesData.fromJson(value.data);
      emit(ShoppingCategorySuccessState());
    }).catchError((error){
      // print(error.toString());
      emit(ShoppingCategoryErrorState());
    });
  }
  FavouritesModel ? favouritesModel;
  void changeFavourite(int id)
  {
     favourite[id] = !favourite[id]!;
     emit(ShoppingFavouriteChangeState());
    DioHelper.postData(path:favorites, data:{"product_id":id},authorization: token).then((value)
    {
      favouritesModel=FavouritesModel.fromJson(value.data);
      if(favouritesModel!.status==false)
      {
        favourite[id] = !favourite[id]!;
      }
      getFavouriteData();
      // print(favouritesModel!.message);
      emit(ShoppingFavouriteSuccessState(favouritesModel!));
    }).catchError(
      (error)
      {
        favourite[id] = !favourite[id]!;
        emit(ShoppingFavouriteErrorState());
      }
    );
  }

  GetFavourite ? getFavourite;
  void getFavouriteData()
  {
    emit(ShoppingGetFavouriteLoadingState());
    DioHelper.getData(path:favorites,authorization: token,lang:"en").then(
    (value) 
    {
      getFavourite=GetFavourite.fromJson(value.data);
      emit(ShoppingGetFavouriteSuccessState());
    }).catchError((error){
      emit(ShoppingGetFavouriteErrorState());
    });
  }

  LoginModel? userModel;

  void getUserData()
  {
    emit(ShoppingGetProfileLoadingState());
    DioHelper.getData(path:profile,authorization: token).then((value)
    {
      userModel=LoginModel.fromJson(value.data);
      // print(userModel!.data!.name);
      emit(ShoppingGetProfileSuccessState());
    }).catchError((error)
    {
      // print(error.toString());
      emit(ShoppingGetProfileErrorState());
    });
  }
  LoginModel ? update;
  void updateUserData({
    required String name,
    required String phone,
    required String email,
  })
  {
    emit(ShoppingUpdateLoadingState());
    DioHelper.putData(path: updateProfile, data: {
      "name":name,
      "phone":phone,
      "email":email,
    },
    authorization: token,
    ).then((value) 
    {
      emit(ShoppingUpdateSuccessState());
      update=LoginModel.fromJson(value.data);
    }).catchError((error){
      emit(ShoppingUpdateErrorState());
    });
  }

   LoginModel? register;
  void userRegister({
    required String name,
    required String phone,
    required String password,
    required String email,
  })
  {
    emit(ShoppingRegisterLoadingState());
    DioHelper.postData(path:registerUser, data:{
      "name" :name,
      'email': email,
      'password':password,
      'phone':phone,
    }).then((value){
      register=LoginModel.fromJson(value.data);
      emit(ShoppingRegisterSuccessState(register!));
    }).catchError((error)
    {
      // print(error.toString());
      emit(ShoppingRegisterErrorState(error.toString()));
    });
  }

    bool isPasswordRegister=true;
  IconData passwordRegister=Icons.visibility_off;
  void changeFormRegister()
  {
    isPasswordRegister=!isPasswordRegister;
    if(isPasswordRegister)
    {
      passwordRegister=Icons.visibility_off;
    }
    else
    {
      passwordRegister=Icons.visibility;
    }
    emit(ShoppingChangeFormState());
  }

    SearchModel ? searchModel;
    void getSearchData({
    required String text,
    })
  {
    emit(ShoppingSearchLoadingState());
    DioHelper.postData(path:search, data:{
        "text":text,
    },authorization: token,
    ).then((value){
      searchModel=SearchModel.fromJson(value.data);
      emit(ShoppingSearchSuccessState());
    }).catchError((error)
    {
      emit(ShoppingSearchErrorState());
    });
  }
}

//cPFIh91FpqZn6bjNErZX0AdnxMUR4IHX1pDojLKRaWfwbVgGLa7ceeHQ0U4gAiFvqRL9pt