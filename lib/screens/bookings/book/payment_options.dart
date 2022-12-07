import 'package:app/bloc/card%20/add_card/add_card_bloc.dart';
import 'package:app/bloc/card%20/get_card/get_card_bloc.dart';
import 'package:app/bloc/charge_user/charge_user_bloc.dart' as charge;
import 'package:app/bloc/payment/payment_sheets/payment_sheets.dart';
import 'package:app/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../bloc/charge_user/charge_user_bloc.dart';
import '../../../common/assets.dart';
import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../common/methods/common.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/headers.dart';
import '../../../model/card_details_model.dart';

class PaymentOptions extends StatefulWidget {
  final double totalPayment;
  final String bookingId;
  final String userId;

  const PaymentOptions({
    Key? key,
    required this.totalPayment,
    required this.bookingId,
    required this.userId,
  }) : super(key: key);

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  String totalPayment = "";
  List<CardDetailsModel> cardList = [];
  int? selectedCard;

  @override
  void initState() {
    BlocProvider.of<GetCardBloc>(context).add(GetCardsRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            bottom: false,
            child: AppHeaders().collapsedHeader(
              text: AppConstants.payOptions,
              context: context,
              backNavigation: true,
              onFilterClick: () {},
            ),
          ),
          verticalSpacer(),
          Expanded(
              child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              width: CommonMethods.deviceWidth(),
              height: CommonMethods.deviceHeight(),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0, top: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                    BlocListener<GetCardBloc, CardState>(
                      listener: (context, state) {
                        if (state is GetCardsLoading) {}
                        if (state is GetCardsInitialLoading) {}
                        if (state is GetCardsFailed) {}
                        if (state is GetCardSuccessfully) {
                          cardList = List<CardDetailsModel>.from(state.cardList.map((e) => CardDetailsModel.fromJson(e)));
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
                    GestureDetector(
                        onTap: () async {
                          await _openCardSheet();
                        },
                        child: paymentOptions(icon: Assets.card.name, text: AppConstants.paymentItems[1])),
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
                    BlocListener<charge.ChargeUserBloc, charge.ChargeUserState>(
                      listener: (ctx, state) {
                        if (state is charge.ChargeUserSuccessfully) {
                          Navigator.of(context).pop(state.response);
                        }
                        if (state is charge.ChargeUserFailed) {
                          CommonMethods().showToast(context: context, message: state.error ?? "");
                        }
                      },
                      child: BlocBuilder<charge.ChargeUserBloc, charge.ChargeUserState>(builder: (context, state) {
                        print(state);
                        return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              _payNowButton(cardList[selectedCard!].id);
                            },
                            child: state is charge.Loading
                                ? const Center(child: CircularProgressIndicator())
                                : appButton(bkColor: selectedCard != null ? Colours.blue.code : Colors.grey, text: AppConstants.payNow, height: 50.0));
                      }),
                    ),
                    verticalSpacer(height: MediaQuery.of(context).size.height * 0.28),
                  ],
                ),
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
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return BlocListener<GetCardBloc, CardState>(
                listener: (context, state) {
                  if (state is GetSelectedCardValue) {
                    state.selectedValue;
                    selectedCard = state.selectedValue;
                    if (mounted) {
                      setState(() {});
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
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
                                Text(
                                  cardList[index].billingDetails.name,
                                  style: AppStyles.buttonText,
                                ),
                                verticalSpacer(),
                                Text(
                                  AppConstants.cardNumberHint,
                                  style: AppStyles.whiteTextW500,
                                ),
                                verticalSpacer(height: 10.0),
                                Text(
                                  "XXXX - XXXX - XXXX - ${cardList[index].card.last4}",
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
                                    /*     Expanded(
                                      flex: 6,
                                      child: Text(
                                        AppConstants.cardCvvHint,
                                        style: AppStyles.whiteTextW500,
                                      ),
                                    ),*/
                                  ],
                                ),
                                verticalSpacer(height: 5.0),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        "${cardList[index].card.expMonth.toString().padLeft(02, "0")}/${cardList[index].card.expYear} ",
                                        style: AppStyles.buttonText,
                                      ),
                                    ),
                                    /*Expanded(
                                      flex: 6,
                                      child: Text(
                                        "255",
                                        style: AppStyles.buttonText,
                                      ),
                                    ),*/
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
        isDismissible: false,
        builder: (context) {
          return const NoWebhookPaymentCardFormScreen();
        });
  }

  _payNowButton(String? id) {
    BlocProvider.of<ChargeUserBloc>(context).add(ChargeUserRequested(
      providerId: widget.userId,
      cardId: id,
      amount: widget.totalPayment.toString(),
      bookingId: widget.bookingId,
    ));
  }
}

class NoWebhookPaymentCardFormScreen extends StatefulWidget {
  const NoWebhookPaymentCardFormScreen({Key? key}) : super(key: key);

  @override
  NoWebhookPaymentCardFormScreenState createState() => NoWebhookPaymentCardFormScreenState();
}

class NoWebhookPaymentCardFormScreenState extends State<NoWebhookPaymentCardFormScreen> {
  final _controller = CardFormEditController();

  @override
  void initState() {
    _controller.addListener(update);
    super.initState();
  }

  void update() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(update);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardFormField(
                controller: _controller,
                countryCode: 'US',
                autofocus: true,
                style: CardFormStyle(
                  borderColor: Colors.blueGrey,
                  textColor: Colors.black,
                  fontSize: 24,
                  placeholderColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 20.0),
              _addCardButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _addCardButton() {
    return BlocBuilder<AddCardBloc, AddCardState>(builder: (context, state) {
      print(state);
      if (state is AddCardLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return ElevatedButton(
            onPressed: () {
              _getCardToken();
            },
            child: Text(AppConstants.addCard));
      }
    });
  }

  void _getCardToken() async {
    TokenData data = await StripeServices.getCardToken();
    if (mounted) {
      BlocProvider.of<AddCardBloc>(context).add(AddCardsRequested(tokenId: data.id));
    }
  }
}
