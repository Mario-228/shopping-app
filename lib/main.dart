import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cache/cache.dart';
import 'package:shopping_app/cubit/shopping_cubit.dart';
import 'package:shopping_app/home_layout.dart';
import 'package:shopping_app/login.dart';
import 'package:shopping_app/onboarding/onboarding.dart';
import 'package:shopping_app/reusable%20components/reusable_components.dart';

void main()async
{
    WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.initalCache();
  Widget ? start;
  if(CacheHelper.getData("onboarding")!=null)
  {
    if(CacheHelper.getData("token")!=null)
    {
      start=const HomeLayout();
    }
    else
    {
      start=const LoginScreen();
    }
  }
  else
  {
    start=const Onboarding();
  }
  token=CacheHelper.getData("token");
  runApp( MyWidget(start: start,));

}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key,required this.start});
  final Widget start;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingCubit()..intialDio()..getHomeData()..getCategoryData()..getFavouriteData()..getUserData()..getSearchData(text: "*"),
      child:   MaterialApp(
        home:start,
        // (CacheHelper.getData("onboarding")!=null && CacheHelper.getData("onboarding")==true) ?const LoginScreen(): const Onboarding()
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark
            )
          ),
          primaryTextTheme:const TextTheme(
            titleMedium: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18.0
            )
          )
        ),
      ),
    );
  }
}

