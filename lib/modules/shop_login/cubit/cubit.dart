import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy/model/login_model.dart';
import 'package:shopy/modules/shop_login/cubit/states.dart';
import 'package:shopy/network/remote/dio_helper.dart';
import 'package:shopy/network/remote/end_points.dart';

class ShopingLoginCubit extends Cubit<ShopLoginStates>{

  ShopingLoginCubit() : super(ShopLoginInitialState());
  static ShopingLoginCubit get (context) => BlocProvider.of(context);

  ShopingLoginModel ?loginModel;

  void userLogin({
  required String email,
  required String password,
}){
    emit(ShopLoginLoadingState());

   DioHelper.postData(
     url: LOGIN,
     data: {
        'email':email,
        'password':password,
      },
   ).then((value){
     print(value!.data);
     loginModel=ShopingLoginModel.fromJson(value.data);
     emit(ShopLoginSuccessState(loginModel!));
   }).catchError((error){
     print(error.toString());
     emit(ShopLoginErrorState(error.toString()));
   });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void passwordVisibility() {
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPassword = !isPassword;
    emit(ShopLoginPasswordVisibilityState());
  }
}