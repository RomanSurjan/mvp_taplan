import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/test/pick_date_container.dart';
import 'package:mvp_taplan/test/pick_money_container.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen225 extends StatefulWidget {
  const Screen225({super.key});

  @override
  State<Screen225> createState() => _Screen225State();
}

class _Screen225State extends State<Screen225> {
  List<bool> isPickedMoney = [
    false,
    false,
    false,
    true,
  ];

  List<int> moneyInt = [
    250,
    500,
    750,
    1000,
  ];

  List<bool> isPickedEvent = [
    true,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Событие коллектива (2/2)\nРабота с Tg-чатом события ',
      child: Padding(
        padding: EdgeInsets.only(
          left: getWidth(context, 16),
          right: getWidth(context, 12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getHeight(context, 17),
            ),
            header(context),
            SizedBox(
              height: getHeight(context, 23),
            ),
            Text(
              'Суммы для групповых подарков:',
              style: TextLocalStyles.roboto500.copyWith(
                color: Colors.white,
                fontSize: 14,
                height: 16.41 / 14,
              ),
            ),
            SizedBox(
              height: getHeight(context, 9),
            ),
            Row(
              children: [
                for (int i = 0; i < moneyInt.length; i++) ...[
                  PickMoneyContainer(
                      price: moneyInt[i].toString(),
                      isPicked: isPickedMoney[i],
                      onTap: () {
                        for (int j = 0; j < isPickedMoney.length; j++) {
                          if (j != i) {
                            isPickedMoney[j] = false;
                          } else {
                            isPickedMoney[j] = true;
                          }
                        }
                        setState(() {});
                      }),
                  SizedBox(
                    width: getWidth(context, 8),
                  ),
                ],
                const Expanded(child: SizedBox()),
                Text(
                  'ВВЕСТИ',
                  style: TextLocalStyles.roboto500.copyWith(
                    color: AppTheme.moneyScaleGreenColor,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    height: 16.41 / 14,
                  ),
                )
              ],
            ),
            SizedBox(
              height: getHeight(context, 48),
            ),
            dateOfEvent(
              context,
              isPicked: isPickedEvent[0],
              onTap: () {
                isPickedEvent[0] = !isPickedEvent[0];
                setState(() {});
              },
              title: 'Дата события:',
            ),
            SizedBox(
              height: getHeight(context, 31),
            ),
            dateOfEvent(
              context,
              isPicked: isPickedEvent[1],
              onTap: () {
                isPickedEvent[1] = !isPickedEvent[1];
                setState(() {});
              },
              title: 'Дата празднования в коллективе:',
            ),
            SizedBox(
              height: getHeight(context, 41),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MvpGradientButton(
                label: 'Сохранить',
                gradient: AppTheme.mainGreenGradient,
                width: getWidth(context, 164),
                height: getHeight(context, 46),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateOfEvent(
    BuildContext context, {
    required bool isPicked,
    VoidCallback? onTap,
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                onTap?.call();
              },
              child: SizedBox(
                height: getHeight(context, 24),
                width: getHeight(context, 24),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(52, 54, 62, 1),
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: const Color.fromRGBO(66, 68, 77, 1),
                      width: 1.5,
                    ),
                  ),
                  child: isPicked ? SvgPicture.asset('assets/svg/check.svg') : null,
                ),
              ),
            ),
            SizedBox(
              width: getWidth(context, 10),
            ),
            Text(
              title,
              style: TextLocalStyles.roboto500.copyWith(
                fontSize: 14,
                height: 16.41 / 14,
                color: isPicked ? AppTheme.mainGreenColor : const Color.fromRGBO(143, 153, 163, 1),
              ),
            )
          ],
        ),
        SizedBox(
          height: getHeight(context, 10),
        ),
        Row(
          children: [
            PickDateContainer(
              height: getHeight(context, 34),
              width: getWidth(context, 296),
              label: 'Введите дату ',
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              height: getHeight(context, 36),
              width: getHeight(context, 36),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(98, 198, 170, 1),
                      Color.fromRGBO(68, 168, 140, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/svg/rollback.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: getHeight(context, 10),
        ),
        Text(
          'Дата и время закрытия донатов:',
          style: TextLocalStyles.roboto500.copyWith(
            color: isPicked ? Colors.white : const Color.fromRGBO(143, 153, 163, 1),
            fontSize: 14,
            height: 16.41 / 14,
          ),
        ),
        SizedBox(
          height: getHeight(context, 8),
        ),
        Row(
          children: [
            PickDateContainer(
              height: getHeight(context, 34),
              width: getWidth(context, 185),
              label: '26 августа 2022',
              textColor: const Color.fromRGBO(244, 199, 217, 1),
            ),
            SizedBox(
              width: getWidth(context, 9),
            ),
            PickDateContainer(
              height: getHeight(context, 34),
              width: getWidth(context, 100),
              label: '19:30',
              textColor: const Color.fromRGBO(244, 199, 217, 1),
            ),
          ],
        ),
      ],
    );
  }

  Widget header(BuildContext context) {
    return SizedBox(
      height: getHeight(context, 105),
      width: getWidth(context, 343),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              contact(context),
              const Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 16),
                ),
                child: categories(context),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Align(
            alignment: Alignment.bottomCenter,
            child: divider(context),
          ),
        ],
      ),
    );
  }

  Widget contact(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: getHeight(context, 54),
          width: getHeight(context, 54),
          child: const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img.png'),
              ),
            ),
          ),
        ),
        SizedBox(
          width: getWidth(context, 8),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Наталья Фадеева (1/99)',
              style: TextLocalStyles.roboto600.copyWith(
                color: const Color.fromRGBO(233, 235, 237, 1),
                fontSize: 14,
                height: 16.41 / 14,
              ),
            ),
            Text(
              'День рождения',
              style: TextLocalStyles.roboto500.copyWith(
                color: AppTheme.moneyScaleGreenColor,
                fontSize: 14,
                height: 16.41 / 14,
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
              '30.06 (+27 дней)',
              style: TextLocalStyles.roboto400.copyWith(
                color: const Color.fromRGBO(188, 192, 200, 1),
                fontSize: 14,
                height: 16.41 / 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget divider(BuildContext context) {
    return SizedBox(
      width: getWidth(context, 343),
      height: getHeight(context, 1),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
          color: const Color.fromRGBO(66, 68, 77, 1),
          width: 1,
        )),
      ),
    );
  }

  Widget categories(BuildContext context) {
    List<List<int>> categories = [
      [0, 0, 0],
      [0, 0, 0],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < categories.length; i++) ...[
          Row(
            children: [
              for (int i = 0; i < categories[0].length; i++) ...[
                SizedBox(
                  height: getHeight(context, 34),
                  width: getHeight(context, 34),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(69, 78, 84, 1),
                    ),
                  ),
                ),
                if (i + 1 != categories[0].length)
                  SizedBox(
                    width: getWidth(context, 3),
                  ),
              ],
            ],
          ),
          SizedBox(
            height: getHeight(context, 3),
          )
        ],
      ],
    );
  }
}
