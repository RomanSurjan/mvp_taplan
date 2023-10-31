import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_bloc.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_state.dart';
import 'package:mvp_taplan/models/models.dart';

class Screen39 extends StatefulWidget {
  final int initialIndex;
  const Screen39({super.key, required this.initialIndex});

  @override
  State<Screen39> createState() => _Screen39State();
}

class _Screen39State extends State<Screen39> {
  late final PageController controller = PageController(initialPage: widget.initialIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<JournalBloc, JournalState>(
        builder: (context,state) {

          return SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: controller,
                itemBuilder: (context, index) {
                  return VideoPlayerItem(
                    videoUrl: state.videosList[index],
                    label: state.contentList[index].label,
                    pageIndex: index,
                  );
                },
                itemCount: state.videosList.length,
                scrollDirection: Axis.vertical,
              ),
            ),
          );
        },
      ),
    );
  }
}
