part of 'screen_215.dart';

class PickYourMoney extends StatefulWidget {
  final bool isPickedWidget;
  final List<int> intPrices;
  final List<bool> isPicked;

  const PickYourMoney({
    super.key,
    required this.isPickedWidget,
    required this.isPicked,
    required this.intPrices,
  });

  @override
  State<PickYourMoney> createState() => _PickYourMoneyState();
}

class _PickYourMoneyState extends State<PickYourMoney> {
  List<String> prices = [
    '100 ₽',
    '250 ₽',
    '500 ₽',
    '1 000 ₽',
  ];


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: getHeight(context, 28),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return PickYourMoneyContainer(
                price: prices[index],
                isPicked: widget.isPicked[index] && widget.isPickedWidget,
                onTap: () {
                  if (widget.isPickedWidget) {
                    for (int i = 0; i < prices.length; i++) {
                      if (i == index) {
                        widget.isPicked[i] = true;
                        context.read<BuyTogetherBloc>().add(
                            SetAdditionalSumEvent(additionalSum: widget.intPrices[i]));
                      } else {
                        widget.isPicked[i] = false;
                      }
                    }
                    setState(() {});
                  }
                });
          },
          separatorBuilder: (_, __) =>
              Padding(padding: EdgeInsets.only(left: getWidth(context, 10))),
          itemCount: prices.length,
        ),
      ),
    );
  }
}
