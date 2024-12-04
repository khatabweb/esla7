part of 'allchats_cubit.dart';

sealed class AllChatsState extends Equatable {
  const AllChatsState();

  @override
  List<Object> get props => [];
}

final class AllChatsInitial extends AllChatsState {}

final class AllChatsLoading extends AllChatsState {}

final class AllChatsSuccess extends AllChatsState {
  final AllChatsModel allChatsModel;

  AllChatsSuccess({required this.allChatsModel});
}

final class AllChatsError extends AllChatsState {
  final String error;

  AllChatsError({required this.error});
}
