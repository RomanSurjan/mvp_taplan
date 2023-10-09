import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_bloc.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_event.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/journal/models_journal/bended_line.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen38 extends StatefulWidget {
  const Screen38({Key? key}) : super(key: key);

  @override
  State<Screen38> createState() => _Screen38State();
}

class _Screen38State extends State<Screen38> {
  @override
  void initState() {
    super.initState();

    context.read<JournalBloc>().add(GetJournalContentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Содержание номера',
      child: BlocBuilder<JournalBloc, JournalState>(builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 18),
                right: getWidth(context, 16),
                left: getWidth(context, 16),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < state.contentList.length; i++) ...[
                    ContentBox(
                      pages: state.contentList[i].page,
                      label: state.contentList[i].label,
                    ),
                    SizedBox(
                      height: getHeight(context, 9),
                    )
                  ],
                  SizedBox(
                    height: getHeight(context, 85),
                  )
                ],
              ),
            ),
            SizedBox(
              height: getHeight(context, 812),
              width: getWidth(context, 375),
              child: CustomPaint(
                painter: BendedLinePainter(
                  color: const Color.fromRGBO(98, 198, 170, 1),
                  leftPadding: getWidth(context, 75),
                  bottomPadding: getHeight(context, 94),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class ContentBox extends StatelessWidget {
  final int pages;
  final String label;

  const ContentBox({
    super.key,
    required this.pages,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: context.watch<ThemeBloc>().state.isDark? const Color.fromRGBO(58, 60, 69, 1): Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(left: 0.03 * MediaQuery.of(context).size.width)),
                SizedBox(
                  height: 0.07 * MediaQuery.of(context).size.height,
                  width: 0.15 * MediaQuery.of(context).size.width,
                  child: Text(
                    pages < 10 ? '0$pages' : '$pages',
                    style: TextStyle(
                      fontFamily: 'Gputeks',
                      color: const Color.fromRGBO(193, 184, 237, 1),
                      fontSize: 0.032 * MediaQuery.of(context).size.height,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 0.035 * MediaQuery.of(context).size.width)),
                Text(
                  label,
                  style: TextLocalStyles.roboto400.copyWith(
                    color: context.watch<ThemeBloc>().state.isDark? Colors.white:Colors.black,
                    fontSize: getHeight(context, 18),
                    height: 21.09 / 18,
                  ),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: const Color.fromRGBO(200, 210, 219, 1),
                  size: 0.045 * MediaQuery.of(context).size.height,
                )
              ],
            )),
      ),
    );
  }
}
