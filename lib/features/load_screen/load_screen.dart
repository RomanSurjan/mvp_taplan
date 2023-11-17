import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/cover_bloc/cover_bloc.dart';
import 'package:mvp_taplan/blocs/cover_bloc/cover_event.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_event.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_bloc.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_event.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_bloc.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_event.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_bloc.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_event.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_event.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({Key? key}) : super(key: key);

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    super.initState();
    //TODO вынести логику в COVERBLOC
    context.read<CoverBloc>().add(GetCoverEvent(bloggerId: 1));
    context.read<PostcardBloc>().add(GetPostcardsEvent(bloggerId: 1));
    context.read<WishListBloc>().add(GetWishListEvent(bloggerId: 1));
    context.read<DateTimeBloc>().add(SetTimeToStreamEvent(bloggerId: 1));
    context.read<ShowcaseBloc>().add(GetShowcaseCardsEvent(bloggerId : 1, cat: 5));
    context.read<JournalBloc>().add(GetJournalContentEvent(bloggerId: 1));

    Future.delayed(
      const Duration(milliseconds: 8000),
      () {
        Navigator.pushReplacementNamed(context, '/nb/journal_1/');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/images/load_logo.gif',
          ),
        ),
      ),
    );
  }
}
