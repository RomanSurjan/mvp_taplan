import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_event.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_state.dart';

class ShowcaseBloc extends Bloc<ShowcaseEvent, ShowcaseState> {
  ShowcaseBloc() : super(ShowcaseState(
      userModel: UserModel(
          celebrate: Celebrate(
            id: 0,
            name: '',
            date: ''
          ),
          name: '',
          presents: []
      )
  )) {
    on<GetShowcaseCardsEvent>(_onGetShowcase);
  }

  _onGetShowcase(GetShowcaseCardsEvent event, Emitter<ShowcaseState> emitter) async {

    final response = await Dio().post(
      'https://qviz.fun/api/v1/get/wishlist/',
      data: {
        'blogger_id': "1",
        'cat': '${event.cat}',
      },
    );

    final UserModel userModel = UserModel.fromJson(response.data);

    emitter(
      state.copyWith(
        userModel: userModel,
      ),
    );
  }
}
