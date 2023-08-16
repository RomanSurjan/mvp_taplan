part of 'screen_213.dart';

class PostCardViewWidget extends StatelessWidget {
  final void Function(int)? onPageChanged;
  final int currentIndex;

  const PostCardViewWidget({
    super.key,
    this.onPageChanged,
    required this.currentIndex,
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
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    PageView.builder(
                      onPageChanged: onPageChanged,
                      controller: controller,
                      itemCount: state.postcards.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          state.postcards[index],
                          width: getWidth(context, 375),
                          height: getHeight(context, 239),
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 15)),
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
                              child: SvgPicture.asset(
                                'assets/svg/arrow_left.svg',
                                colorFilter: const ColorFilter.mode(
                                  AppTheme.mainGreenColor,
                                  BlendMode.srcIn,
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
                              child: SvgPicture.asset(
                                'assets/svg/arrow_right.svg',
                                colorFilter: const ColorFilter.mode(
                                  AppTheme.mainGreenColor,
                                  BlendMode.srcIn,
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
                top: getHeight(context, 8),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: getHeight(context, 6),
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                      Padding(padding: EdgeInsets.only(left: getWidth(context, 8))),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.postcards.length,
                  itemBuilder: (context, index) {

                    return SizedBox(
                      height: getHeight(context, 6),
                      width: getWidth(context, 6),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index % 25 == currentIndex % 25
                              ? AppTheme.mainGreenColor
                              : index == 4
                                  ? AppTheme.mainPinkColor
                                  : const Color.fromRGBO(66, 68, 77, 1),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
