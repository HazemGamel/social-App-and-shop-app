
import 'package:first_app/Network/Dio.dart';
import 'package:first_app/modelsShop/searchmodel.dart';
import 'package:first_app/shared/CONSTS.dart';
import 'package:first_app/shop_app/searchStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit():super(InitioalSearchState());

  static SearchCubit get(context)=>BlocProvider.of(context);

SearchModel Model;
  void SearchProduct(String text){
    emit(LodingSearchState());

    DoiHelper.postdata(url:'products/search',
        token: token,
        data:{
      'text':text,
        }).then((value) {
       Model=SearchModel.fomJson(value.data);
          emit(SuccessSearchState());
    }).catchError((error){
      print("error search is ${error.toString()}");
      emit(ErrorSearchState());
    });

  }
}