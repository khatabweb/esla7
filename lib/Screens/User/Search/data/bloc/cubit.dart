import 'package:dio/dio.dart';
import '../repo/search_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/model.dart';
import 'state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitState());

  static SearchCubit get(context) => BlocProvider.of(context);

  String? name;
  late SearchModel searchModel;

  Future<void> searchDetails() async {
    emit(SearchLoadingState());
    try {
      print("name: $name");
      FormData formData = FormData.fromMap({
        "name": name,
      });
      final response = await SearchRepo.search(formData: formData);
      response.when(
        success: (data) {
          searchModel = data;
          emit(SearchSuccessState(searchModel));
        },
        failure: (error) {
          emit(SearchErrorState(error.apiErrorModel.message!));
        },
      );
    } catch (e) {
      print("catch error :::::::::::::: ${e.toString()}");
      emit(SearchErrorState(e.toString()));
    }
  }
}
