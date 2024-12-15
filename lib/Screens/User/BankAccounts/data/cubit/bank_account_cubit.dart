import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../model/model.dart';
import '../repo/bank_account.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bank_account_state.dart';

class BankAccountCubit extends Cubit<BankAccountState> {
  BankAccountCubit() : super(BankAccountInitial());
  static BankAccountCubit get(context) => BlocProvider.of(context);
  late BankAccountsModel bankAccountsModel;
  Future<void> getBanks({required int? ownerId}) async {
    final formData = FormData.fromMap({"owner_id": ownerId});
    final response =
        await BankAccountRepo.createBankAccount(formData: formData);
    response.when(success: (success) {
      bankAccountsModel = success;
      emit(BankAccountSuccess(bankAccountsModel: success));
    }, failure: (failure) {
      emit(BankAccountError(error: failure.apiErrorModel.message!));
    });
  }
}
