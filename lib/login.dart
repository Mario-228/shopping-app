import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cache/cache.dart';
import 'package:shopping_app/cubit/shopping_cubit.dart';
import 'package:shopping_app/cubit/states.dart';
import 'package:shopping_app/home_layout.dart';
import 'package:shopping_app/register.dart';
import 'package:shopping_app/reusable%20components/reusable_components.dart';
TextEditingController emailController=TextEditingController();
TextEditingController passController=TextEditingController();
var formKey=GlobalKey<FormState>();
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingCubit,ShoppingStates>(
      listener: (context, state) {
        if(state is ShoppingLoginSuccessState)
        {
          if(state.model.status!)
          {
            // print(state.model.status);
            toast(state.model.message!,Colors.green,5);
            CacheHelper.saveData("token",state.model.data!.token).then(
              (value) 
              {
                token=state.model.data!.token;
                ShoppingCubit.get(context).getFavouriteData();
                ShoppingCubit.get(context).getUserData();
                navigateAndFinish(context, const HomeLayout());
           });
          }
          else
          {
            // print(state.model.status);
            toast(state.model.message!,Colors.red,5);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor:Colors.white ,
          elevation: 0.0,
        ),
        body:  Center(
          child: SingleChildScrollView(
            physics:const BouncingScrollPhysics() ,
            child: Padding(
              padding:  const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text(
                      "LOGIN",
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),
                    ),
                     const SizedBox(height: 10.0,),
                     const Text(
                      "Login To Browse Our Offers",
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.grey),
                    ),
                      const SizedBox(height: 30.0,)
                      ,
                    formfield(
                      controller:emailController ,
                      validate: (value)
                      {
                        if(value=="")
                        {
                          return "Email Must Not Be Empty";
                        }
                        else
                        {
                          return null;
                        }
                      },
                      type: TextInputType.emailAddress,
                      label: "Email",
                      prefix:const Icon(Icons.email_outlined)
                         ),
                   const SizedBox(height: 20.0,),
                    formfield(
                      controller:passController ,
                      validate: (value)
                      {
                        if(value=="")
                        {
                          return "password Must Not Be Empty";
                        }
                        else
                        {
                          return null;
                        }
                      },
                      type: TextInputType.visiblePassword,
                      label: "Password",
                      sumbit: (value){
                        if(formKey.currentState!.validate())
                        {
                           ShoppingCubit.get(context).login(emailController.text,passController.text);
                        }
                      },
                      prefix:const Icon(Icons.lock_outline),
                      suffix:  IconButton(onPressed: (){
                        ShoppingCubit.get(context).changeForm();}, icon: Icon(ShoppingCubit.get(context).password)),
                      ispassword:ShoppingCubit.get(context).isPassword,
                         ),
                         const SizedBox(height: 20.0,)
                         ,
                      ConditionalBuilder(
                      condition: state is! ShoppingLoginLoadingState,
                      builder:(context) => 
                      MaterialButton(onPressed: (){
                        if(formKey.currentState!.validate())
                        {
                           ShoppingCubit.get(context).login(emailController.text,passController.text);
                        }
                      },
                      color: Colors.blue[400],
                      minWidth: double.infinity,
                      height: 50.0,
                      child: const Text("LOGIN" ,style: TextStyle(color: Colors.white,fontSize: 18.0),),
                      ), 
                      fallback: (context) => const Center(child:  CircularProgressIndicator()),
                        ),
                      const SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: 
                      [
                        const Text("Don't Have An Account?" ,style: TextStyle(color: Colors.black,fontSize: 18.0),),
                        TextButton(onPressed: (){
                          navigateTo(context, const RegisterScreen());
                        }, child: const Text("REGISTER NOW.",style: TextStyle(fontSize: 18.0))),
                      ],
                        ),
                        ]
                ),
              ),
            ),
          ),
        ),
      );
      },
    );
  }
}