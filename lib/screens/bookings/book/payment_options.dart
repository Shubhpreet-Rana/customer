import 'package:app/bloc/card%20/get_card/get_card_bloc.dart';
import 'package:app/bloc/charge_user/charge_user_bloc.dart';
import 'package:app/bloc/payment/payment_bloc.dart';
import 'package:app/bloc/payment/payment_sheets/payment_sheets.dart';
import 'package:app/common/styles/styles.dart';
import 'package:app/model/card_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets.dart';
import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../common/methods/common.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/headers.dart';

class PaymentOptions extends StatefulWidget {
  final double totalPayment;
  String? bookingId;

  PaymentOptions({Key? key, required this.totalPayment, this.bookingId}) : super(key: key);

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  String totalPayment = "";
  List<dynamic> cardList = [];

  var paymentIntent;
  int? selectedCard;

  @override
  void initState() {
    BlocProvider.of<GetCardBloc>(context).add(GetCardsRequested());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(bottom: false, child: AppHeaders().collapsedHeader(text: AppConstants.payOptions, context: context, backNavigation: true, onFilterClick: () {})),
          verticalSpacer(),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              width: CommonMethods.deviceWidth(),
              height: CommonMethods.deviceHeight(),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0, top: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: CommonMethods.deviceWidth(),
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    decoration: BoxDecoration(color: Colours.lightGray.code, borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      r"$" + widget.totalPayment.toString(),
                      style: AppStyles.darkText14,
                    ),
                  ),
                  verticalSpacer(),
                  BlocListener<GetCardBloc, GetCardState>(
                    listener: (context, state) {
                      if (state is GetCardsLoading) {
                        print("Loading");
                      }
                      if (state is GetCardsInitialLoading) {
                        print("Initial Loading");
                      }
                      if (state is GetCardsFailed) {
                        print("Failed");
                      }
                      if (state is GetCardSuccessfully) {
                        cardList = state.cardList;
                        if (mounted) {
                          setState(() {});
                        }
                      }
                    },
                    child: _cardListWidget(),
                  ),
                  verticalSpacer(height: 30.0),
                  Text(AppConstants.newPayment, style: AppStyles.blackSemiBold),
                  verticalSpacer(height: 30.0),
                  _creditCard(),
                  Container(
                    height: 1.5,
                    color: Colours.hintColor.code,
                  ),
                  paymentOptions(icon: Assets.card.name, text: AppConstants.paymentItems[1]),
                  Container(
                    height: 1.5,
                    color: Colours.hintColor.code,
                  ),
                  paymentOptions(icon: Assets.bank.name, text: AppConstants.paymentItems[0]),
                  Container(
                    height: 1.5,
                    color: Colours.hintColor.code,
                  ),
                  verticalSpacer(height: 30.0),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                          _payNowButton(cardList[selectedCard!]["id"]);
                      },
                      child: appButton(bkColor:selectedCard!=null? Colours.blue.code:Colors.grey, text: AppConstants.payNow, height: 50.0)),
                  verticalSpacer(height: 5.0),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }

  Widget paymentOptions({required String icon, required String text}) => Padding(
        padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    width: 30.0,
                    child: SvgPicture.asset(
                      icon,
                      fit: BoxFit.contain,
                    )),
                horizontalSpacer(),
                Text(
                  text,
                  style: AppStyles.blackSemiW400,
                )
              ],
            ),
            const Icon(Icons.add)
          ],
        ),
      );

  _cardListWidget() {
    return cardList.isNotEmpty
        ? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: cardList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return BlocListener<GetCardBloc, GetCardState>(
                listener: (context, state) {
                  if (state is GetSelectedCardValue) {
                    selectedCard = state.selectedCard!;
                    if (mounted) {
                      setState(() {});
                    }
                  }
                },
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    BlocProvider.of<GetCardBloc>(context).add(GetSelectedCard(index));
                  },
                  child: Row(
                    children: [
                      _radioButton(index),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          width: CommonMethods.deviceWidth(),
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                          decoration: BoxDecoration(color: Colours.blue.code, borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppConstants.holderName,
                                style: AppStyles.whiteTextW500,
                              ),
                              verticalSpacer(height: 10.0),
                              const Text(
                                "Peter Smith",
                                style: AppStyles.buttonText,
                              ),
                              verticalSpacer(),
                              Text(
                                AppConstants.cardNumberHint,
                                style: AppStyles.whiteTextW500,
                              ),
                              verticalSpacer(height: 10.0),
                              const Text(
                                "XXXX - XXXX - XXXX - XXXX",
                                style: AppStyles.buttonText,
                              ),
                              verticalSpacer(),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      AppConstants.cardExpDateHint,
                                      style: AppStyles.whiteTextW500,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      AppConstants.cardCvvHint,
                                      style: AppStyles.whiteTextW500,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpacer(height: 5.0),
                              Row(
                                children: const [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "25 Mar, 2025",
                                      style: AppStyles.buttonText,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      "255",
                                      style: AppStyles.buttonText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
        : const SizedBox();
  }

  _creditCard() {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          _openCardSheet();
        },
        child: paymentOptions(icon: Assets.card.name, text: AppConstants.paymentItems[2]));
  }

  _radioButton(int index) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 30,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 1.5)),
      child: CircleAvatar(
        maxRadius: 5,
        backgroundColor: selectedCard == index ? Colors.black : Colors.transparent,
      ),
    );
  }

  _openCardSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return NoWebhookPaymentCardFormScreen();
        });
  }

  _payNowButton(String? id) {
    BlocProvider.of<ChargeUserBloc>(context).add(ChargeUserRequested(providerId: "1", cardId: id, amount: widget.totalPayment.toString(), bookingId: widget.bookingId));
  }
}

class NoWebhookPaymentCardFormScreen extends StatefulWidget {
  @override
  _NoWebhookPaymentCardFormScreenState createState() => _NoWebhookPaymentCardFormScreenState();
}

class _NoWebhookPaymentCardFormScreenState extends State<NoWebhookPaymentCardFormScreen> {
  final controller = CardFormEditController();

  @override
  void initState() {
    controller.addListener(update);
    super.initState();
  }

  void update() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(update);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CardFormField(
              controller: controller,
              countryCode: 'US',
              style: CardFormStyle(
                borderColor: Colors.blueGrey,
                textColor: Colors.black,
                fontSize: 24,
                placeholderColor: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            _addCardButton()
          ],
        ),
      ),
    );
  }

  _addCardButton() {
    return ElevatedButton(
        onPressed: () {
          _getCardToken();
        },
        child: const Text("Add card"));
  }

  _getCardToken() async {
    var data = await StripeServices.getCardToken();
    print(data);
  }
}
