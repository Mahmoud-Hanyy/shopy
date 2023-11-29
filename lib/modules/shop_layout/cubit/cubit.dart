import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy/modules/shop_layout/cubit/states.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0 ;

  void changeBottomNav(int index){
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
}