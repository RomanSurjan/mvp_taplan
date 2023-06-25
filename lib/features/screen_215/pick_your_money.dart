
part of 'screen_215.dart';


class PickYourMoney extends StatefulWidget {
  const PickYourMoney({super.key});

  @override
  State<PickYourMoney> createState() => _PickYourMoneyState();
}

class _PickYourMoneyState extends State<PickYourMoney> {

  List<String> prices =[
    '500 ₽',
    '1000 ₽',
    '5000 ₽',
  ];
  List<bool> isPicked =[
    false,
    false,
    true,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context, 20),
      width: getWidth(context, 218),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return PickYourMoneyContainer(
              price: prices[index],
              isPicked: isPicked[index],
              onTap: (){
                for(int i = 0; i < prices.length; i++){
                  if(i == index){
                    isPicked[i] = true;
                  }else{
                    isPicked[i] = false;
                  }
                }
                setState(() {});
              },
            );
          },
          separatorBuilder:(_, __) => Padding(padding: EdgeInsets.only(left: getWidth(context, 10))),
          itemCount: prices.length,
      ),
    );
  }
}
