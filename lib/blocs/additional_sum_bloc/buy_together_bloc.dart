import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_event.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_state.dart';

class BuyTogetherBloc extends Bloc<BuyTogetherEvent, BuyTogetherState> {
  BuyTogetherBloc() : super(BuyTogetherState(additionalSum: 0)) {
    on<SetAdditionalSumEvent>(_onAdditionalSum);
  }

  _onAdditionalSum(SetAdditionalSumEvent event, Emitter<BuyTogetherState> emitter) {
    emitter(
      state.copyWith(additionalSum: event.additionalSum),
    );
  }
}