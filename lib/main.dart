import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/paymennt_bloc/payment_bloc.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_bloc.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_bloc.dart';
import 'package:mvp_taplan/features/screen_30/screen_30.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DateTimeBloc>(
          create: (context) => DateTimeBloc(
            date: '',
            time: '',
          ),
        ),
        BlocProvider<PostcardBloc>(
          create: (context) => PostcardBloc(),
        ),
        BlocProvider<BuyTogetherBloc>(
          create: (context) => BuyTogetherBloc(),
        ),
        BlocProvider<WishListBloc>(
          create: (context) => WishListBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<PaymentBloc>(
          create: (context) => PaymentBloc(),
        ),
        BlocProvider(
          create: (context) => ShowcaseBloc(),
        ),
      ],
      child: const MaterialApp(
        title: 'MVP',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Screen30();
  }
}
