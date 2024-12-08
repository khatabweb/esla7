import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esla7/Screens/User/BankAccounts/data/model/model.dart';
import 'package:esla7/Screens/User/BankAccounts/data/repo/bank_account.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bank_account_state.dart';

class BankAccountCubit extends Cubit<BankAccountState> {
  BankAccountCubit() : super(BankAccountInitial());
  static BankAccountCubit get(context) => BlocProvider.of(context);
  late BankAccountsModel bankAccountsModel;
  Future<void> getBanks() async {
    final response = await BankAccountRepo.createBankAccount();
    response.when(success: (success) {
      bankAccountsModel = success;
      emit(BankAccountSuccess(bankAccountsModel: success));
    }, failure: (failure) {
      emit(BankAccountError(error: failure.apiErrorModel.message!));
    });
  }
}
