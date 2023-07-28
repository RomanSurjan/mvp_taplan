part of 'screen_215.dart';

class PickYourMoney extends StatefulWidget {
  final bool isPicked;

  const PickYourMoney({
    super.key,
    required this.isPicked,
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
  List<bool> isPicked = [
    false,
    false,
    true,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: getHeight(context, 20),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return PickYourMoneyContainer(
              price: prices[index],
              isPicked: isPicked[index] && widget.isPicked,
              onTap: () {
                for (int i = 0; i < prices.length; i++) {
                  if (i == index) {
                    isPicked[i] = true;
                  } else {
                    isPicked[i] = false;
                  }
                }
                setState(() {});
              },
            );
          },
          separatorBuilder: (_, __) => Padding(padding: EdgeInsets.only(left: getWidth(context, 10))),
          itemCount: prices.length,
        ),
      ),
    );
  }
}
