import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_bloc.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/features/screen_39/screen_39.dart';
import 'package:mvp_taplan/journal/models_journal/bended_line.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen38 extends StatefulWidget {
  final VoidCallback? onBack;

  const Screen38({
    super.key,
    this.onBack,
  });

  @override
  State<Screen38> createState() => _Screen38State();
}

class _Screen38State extends State<Screen38> {
  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Содержание номера',
      onBack: widget.onBack,
      child: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Screen39(initialIndex: i),
                            ),
                          );
                        },
                        child: ContentBox(
                          pages: state.contentList[i].page,
                          label: state.contentList[i].label,
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 9),
                      ),
                    ],
                    Image.asset(
                      context.watch<ThemeBloc>().state.isDark
                          ? 'assets/images/content_logo_dark.png'
                          : 'assets/images/content_logo_light.png',
                    ),
                  ],
                ),
              ),
              MouseRegion(
                opaque: false,
                child: SizedBox(
                  height: getHeight(context, 812),
                  width: getWidth(context, 375),
                  child: CustomPaint(
                    painter: BendedLinePainter(
                      color: const Color.fromRGBO(98, 198, 170, 1),
                      leftPadding: getWidth(context, 75),
                      bottomPadding: getHeight(context, 84),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
    return SizedBox(
      height: 0.055 * MediaQuery.of(context).size.height,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: context.watch<ThemeBloc>().state.isDark
              ? const Color.fromRGBO(58, 60, 69, 1)
              : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(left: 0.03 * MediaQuery.of(context).size.width)),
            SizedBox(
              width: 0.15 * MediaQuery.of(context).size.width,
              child: Text(
                pages < 10 ? '0$pages' : '$pages',
                style: TextStyle(
                  fontFamily: 'Gputeks',
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(193, 184, 237, 1),
                  fontSize: getHeight(context, 28),
                  height: 44 / 28,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 0.035 * MediaQuery.of(context).size.width)),
            Text(
              label,
              style: TextLocalStyles.roboto400.copyWith(
                color: context.watch<ThemeBloc>().state.isDark ? Colors.white : Colors.black,
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
        ),
      ),
    );
  }
}
