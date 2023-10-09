part of 'screen_213.dart';

class PostCardViewWidget extends StatelessWidget {
  final void Function(int)? onPageChanged;
  final int currentIndex;
  final List<String> postcards;

  const PostCardViewWidget({
    super.key,
    this.onPageChanged,
    required this.currentIndex,
    required this.postcards,
  });

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 4);

    return BlocBuilder<PostcardBloc, PostcardState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: getWidth(context, 375),
              height: getHeight(context, 239),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: context.read<ThemeBloc>().state.postcardShadowColor,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 11)),
                      child: PageView.builder(
                        onPageChanged: onPageChanged,
                        controller: controller,
                        itemCount: postcards.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            postcards[index],
                            width: getWidth(context, 375),
                            height: getHeight(context, 239),
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 5)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.animateToPage(
                                  currentIndex - 1,
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.linear,
                                );
                              },
                              child: SizedBox(
                                height: getHeight(context, 48),
                                width: getWidth(context, 22),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(98, 198, 170, 1),
                                        Color.fromRGBO(68, 168, 140, 1),
                                      ],
                                    ),
                                  ),
                                  child: Image.asset('assets/images/image 300.png'),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.animateToPage(
                                  currentIndex + 1,
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.linear,
                                );
                              },
                              child: SizedBox(
                                height: getHeight(context, 48),
                                width: getWidth(context, 22),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(98, 198, 170, 1),
                                        Color.fromRGBO(68, 168, 140, 1),
                                      ],
                                    ),
                                  ),
                                  child: Image.asset('assets/images/image 301.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 5),
              ),
            ),
            SizedBox(
              height: getHeight(context, 6),
              child: ListView.separated(
                separatorBuilder: (_, __) =>
                    Padding(padding: EdgeInsets.only(left: getWidth(context, 8))),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: getWidth(context, 3)),
                itemCount: postcards.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: getHeight(context, 6),
                    width: getWidth(context, 6),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index % 25 == currentIndex % 25
                            ? context.watch<ThemeBloc>().state.dotGreenColor
                            : index == 4
                                ? context.watch<ThemeBloc>().state.isDark
                                    ? AppTheme.mainPinkColor
                                    : const Color.fromRGBO(241, 171, 193, 1)
                                : context.read<ThemeBloc>().state.postcardContainerColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
