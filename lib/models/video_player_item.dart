part of 'models.dart';

class VideoPlayerItem extends StatefulWidget {
  final MvpVideoModel videoModel;
  final String label;
  final int pageIndex;
  final bool fromShowcase;

  const VideoPlayerItem({
    super.key,
    required this.videoModel,
    required this.label,
    required this.pageIndex,
    required this.fromShowcase,
  });

  @override
  VideoPlayerItemState createState() => VideoPlayerItemState();
}

class VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();

    _initPlayer();
  }

  void _initPlayer() async {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoModel.videoUrl),
      videoPlayerOptions: VideoPlayerOptions(),
    );

    await videoPlayerController.initialize().then(
      (_) {
        setState(() {});
      },
    );

    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.5);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: videoPlayerController.value.size.width,
                height: videoPlayerController.value.size.height,
                child: videoPlayerController.value.isInitialized
                    ? VideoPlayer(
                        videoPlayerController,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (videoPlayerController.value.isPlaying) {
                videoPlayerController.pause();
              } else {
                videoPlayerController.play();
              }
            },
            child: const SizedBox.expand(),
          ),
          Positioned(
            top: getHeight(context, 53),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: getHeight(context, 315),
                width: getWidth(context, 45),
                child: ColoredBox(
                  color: const Color.fromRGBO(63, 63, 63, 0.4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_left,
                        color: const Color.fromRGBO(200, 210, 219, 1),
                        size: getHeight(context, 35),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          widget.label,
                          style: TextLocalStyles.roboto400.copyWith(
                            color: Colors.white,
                            fontSize: getHeight(context, 18),
                            height: 21.09 / 18,
                          ),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 4,
                        child: Text(
                          widget.pageIndex >= 10 ? '${widget.pageIndex}' : '0${widget.pageIndex}',
                          style: TextLocalStyles.gputeks500.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color.fromRGBO(193, 184, 237, 1),
                            fontSize: 28,
                            height: 46.61 / 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.videoModel.presentId != null)
            Positioned(
              right: getWidth(context, 10),
              top: getHeight(context, 10),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    if (widget.fromShowcase) {
                      Navigator.pop(context);
                    } else {
                      context.read<JournalBloc>().add(
                            GetPresentEvent(
                              presentId: widget.videoModel.presentId!,
                              context: context,
                            ),
                          );
                    }
                  },
                  child: SizedBox(
                    height: getHeight(context, 40),
                    width: getHeight(context, 40),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Icon(
                        Icons.arrow_back_outlined,
                        size: getHeight(context, 40),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            left: getWidth(context, 328),
            top: getHeight(context, 500),
            child: Column(
              children: [
                buildControlButton(
                  context,
                  'assets/svg/heart.svg',
                  widget.videoModel.likes,
                ),
                SizedBox(height: getHeight(context, 10)),
                buildControlButton(
                  context,
                  'assets/svg/comment.svg',
                  widget.videoModel.comments,
                ),
                SizedBox(height: getHeight(context, 10)),
                buildControlButton(
                  context,
                  'assets/svg/share-alt.svg',
                  widget.videoModel.comments,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildControlButton(BuildContext context, String svgImage, int value) {
  return Column(
    children: [
      SvgPicture.asset(
        svgImage,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
      Text(
        value.toString(),
        style: TextLocalStyles.roboto600.copyWith(
          color: Colors.white,
          fontSize: getHeight(context, 14),
          height: 16.41 / 14,
        ),
      ),
    ],
  );
}
