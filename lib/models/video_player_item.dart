part of 'models.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String label;
  final int pageIndex;

  const VideoPlayerItem({
    super.key,
    required this.videoUrl,
    required this.label,
    required this.pageIndex,
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
    videoPlayerController = VideoPlayerController.network(
      widget.videoUrl,
    )..initialize().then(
        (_) {
          if (mounted) {
            setState(() {});
          }
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
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  videoPlayerController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(
                            videoPlayerController,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
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
                height: getHeight(context, 285),
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
                        quarterTurns: 3,
                        child: Text(
                          widget.pageIndex + 1 >= 10
                              ? '${widget.pageIndex + 1}'
                              : '0${widget.pageIndex + 1}',
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
          Positioned(
            right: getWidth(context, 10),
            top: getHeight(context, 10),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
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
          )
        ],
      ),
    );
  }
}
