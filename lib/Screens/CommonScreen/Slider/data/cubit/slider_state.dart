part of 'slider_cubit.dart';

sealed class SliderState extends Equatable {
  const SliderState();

  @override
  List<Object> get props => [];
}

final class SliderInitial extends SliderState {}

final class SliderLoading extends SliderState {}

final class SliderSuccess extends SliderState {
  final SliderModel sliderModel;
  SliderSuccess({required this.sliderModel});
}

final class SliderError extends SliderState {
  final String error;
  SliderError({required this.error});
}
