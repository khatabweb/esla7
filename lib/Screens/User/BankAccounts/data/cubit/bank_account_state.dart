part of 'bank_account_cubit.dart';

sealed class BankAccountState extends Equatable {
  const BankAccountState();

  @override
  List<Object> get props => [];
}

final class BankAccountInitial extends BankAccountState {}

final class BankAccountLoading extends BankAccountState {}

final class BankAccountError extends BankAccountState {
  final String error;
  const BankAccountError({required this.error});
}

final class BankAccountSuccess extends BankAccountState {
  final BankAccountsModel bankAccountsModel;
  const BankAccountSuccess({required this.bankAccountsModel});
}
