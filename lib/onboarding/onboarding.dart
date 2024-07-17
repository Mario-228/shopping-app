import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cache/cache.dart';
import 'package:shopping_app/cubit/shopping_cubit.dart';
import 'package:shopping_app/cubit/states.dart';
import 'package:shopping_app/login.dart';
import 'package:shopping_app/reusable%20components/reusable_components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnboardingScreen
{
  String image;
  String text;
  String body;

  OnboardingScreen(this.image,this.text,this.body);
}
      List<OnboardingScreen> model=[
      OnboardingScreen("https://media.web.userguiding.com/uploads/2021/06/22031254/onboarding-users.jpg","Board1","Body1"),
      OnboardingScreen("https://media.web.userguiding.com/uploads/2021/06/22031254/onboarding-users.jpg","Board2","Body2"),
      OnboardingScreen("https://media.web.userguiding.com/uploads/2021/06/22031254/onboarding-users.jpg","Board3","Body3")
    ];
    var onboardingController=PageController();
class Onboarding extends StatelessWidget {
  const Onboarding({super.key});
  @override
  Widget build(BuildContext context) {

    void submit()
    {
  CacheHelper.saveData("onboarding",true).then((value) 
    {
    if(value)
    {
        navigateAndFinish(context, const LoginScreen());
    }
    },);
  }


    return BlocConsumer<ShoppingCubit,ShoppingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
      appBar: AppBar(
        actions: [
         TextButton(onPressed:submit ,child: const Text("SKIP",style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 17.0,fontWeight:FontWeight.bold,),),),
        ],
        backgroundColor:Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (context, index) 
                    {
                      if(index==model.length-1)
                      {
                        ShoppingCubit.get(context).changeOnboarding(true);
                        return itemBuilder(model[index]);
                      }
                      else
                      {
                      ShoppingCubit.get(context).changeOnboarding(false);
                      return itemBuilder(model[index]);
                      }
                    },
                    itemCount: model.length,
                    controller: onboardingController,
                    physics:const BouncingScrollPhysics(),
                  ),
                ),
              const  SizedBox(height: 30.0,),
                Row
               (
                  children: [
                    SmoothPageIndicator(
                     controller: onboardingController,
                     count: model.length,
                     effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.blueAccent,
                        dotHeight:10.0,
                        dotWidth:10.0,
                        spacing: 5.0,
                        expansionFactor: 4.0,
                     ),
                     ),
                    const Spacer(),
                    FloatingActionButton(onPressed:(){
                      if(ShoppingCubit.get(context).isFinal)
                      {
                       submit();
                      }
                      else
                      {
                      onboardingController.nextPage
                      (
                        duration:const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                       );
                      }
                    },
                    child: const Icon(Icons.arrow_forward),
                    )
                  ],
                )
              ],
            ),
          ) ,
    );
      },
    
    );
  }
    Widget itemBuilder(OnboardingScreen model)=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(image: NetworkImage(model.image),
            width: double.infinity,
            ),
          )
          ,
         const SizedBox(height: 20.0,),
          Text(model.text,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          ),
         const SizedBox(height: 15.0,),
          Text(model.body,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          )
        ],
      );
}