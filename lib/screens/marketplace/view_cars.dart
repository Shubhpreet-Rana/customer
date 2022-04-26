import 'package:app/common/assets.dart';
import 'package:app/screens/marketplace/view_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/styles/styles.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/headers.dart';
import '../maps/maps_page.dart';

class ViewCars extends StatefulWidget {
  const ViewCars({Key? key}) : super(key: key);

  @override
  State<ViewCars> createState() => _ViewCarsState();
}

class _ViewCarsState extends State<ViewCars> {
  int selectedTab = 1;

  @override
  void initState() {
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
          SafeArea(bottom: false, child: AppHeaders().collapsedHeader(text: AppConstants.marketplace, context: context, backNavigation: true, onFilterClick: () {})),
          verticalSpacer(),
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    selectedTab = 1;
                  });
                },
                child: Text(
                  AppConstants.allCars,
                  textAlign: TextAlign.center,
                  style: selectedTab == 1 ? AppStyles.whiteText : AppStyles.blueLightText,
                ),
              )),
              horizontalSpacer(width: 10.0),
              Expanded(
                  child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    selectedTab = 2;
                  });
                },
                child: Text(
                  AppConstants.myListedCars,
                  textAlign: TextAlign.center,
                  style: selectedTab == 2 ? AppStyles.whiteText : AppStyles.blueLightText,
                ),
              )),
            ],
          ),
          verticalSpacer(height: 10.0),
          Expanded(
              child: Container(
            width: CommonMethods.deviceWidth(),
            height: CommonMethods.deviceHeight(),
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0, top: 20.0),
            decoration: BoxDecoration(
              color: Colours.lightGray.code,
            ),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  itemCount: selectedTab == 1 ? cars.length : 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    index = selectedTab == 1 ? index : 3;
                    return listItem(cars[index]);
                  }),
            ),
          ))
        ],
      )),
    );
  }

  Widget listItem(CarsForSell car) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(10),
                  topLeft: const Radius.circular(10),
                  bottomRight: Radius.circular(selectedTab == 2 ? 10 : 0),
                  bottomLeft: Radius.circular(selectedTab == 2 ? 10 : 0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        car.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  horizontalSpacer(width: 10.0),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            car.title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: AppStyles.blackSemiBold,
                          ),
                          Text(
                            car.year,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: AppStyles.lightText,
                          )
                        ],
                      ),
                      Text(
                        "Posted on " + car.postedDate,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppStyles.lightText12,
                      ),
                      verticalSpacer(height: 5.0),
                      Text(
                        car.price,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: AppStyles.textBlueBold,
                      ),
                      verticalSpacer(height: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Color:",
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: AppStyles.lightText,
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              car.color,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: AppStyles.blackText,
                            ),
                          )
                        ],
                      ),
                      verticalSpacer(height: 5.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Mileage:",
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: AppStyles.lightText,
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              car.mileage,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: AppStyles.blackText,
                            ),
                          )
                        ],
                      ),
                      verticalSpacer(height: 5.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Capacity:",
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: AppStyles.lightText,
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              car.capacity,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: AppStyles.blackText,
                            ),
                          )
                        ],
                      )
                    ],
                  ))
                ],
              )),
          selectedTab == 1
              ? Container(
                  margin: const EdgeInsets.only(bottom: 20.0, top: 2.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colours.darkGray.code,
                          radius: 20.0,
                          backgroundImage: AssetImage(car.sellerImage),
                        ),
                        horizontalSpacer(width: 5.0),
                        Text(
                          car.sellerName,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: AppStyles.blackSemiW400_1,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(
                                  builder: (context) => const MyAppMap(
                                        showPickUp: false,
                                      )));
                            },
                            child: rowButton(bkColor: Colours.lightWhite.code, textColor: Colours.blue.code, text: AppConstants.location1, paddingHorizontal: 8.0, paddingVertical: 7.0)),
                        horizontalSpacer(width: 5.0),
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(builder: (context) => ViewCarDetails(car: car)));
                            },
                            child: rowButton(bkColor: Colours.blue.code, text: AppConstants.details, paddingHorizontal: 8.0, paddingVertical: 7.0))
                      ],
                    )
                  ]))
              : const SizedBox.shrink()
        ],
      );
}

class CarsForSell {
  final String image;
  final String title;
  final String postedDate;
  final String year;
  final String price;
  final String color;
  final String mileage;
  final String capacity;
  final String sellerImage;
  final String sellerName;
  final bool carOwner;

  CarsForSell(this.image, this.title, this.postedDate, this.year, this.price, this.color, this.mileage, this.capacity, this.sellerImage, this.sellerName, this.carOwner);
}

List<CarsForSell> cars = [
  CarsForSell(Assets.carAcura.name, "Acura ILX", "2 Jan, 2022", "2020", r"$ 1,25,000", "White", "18 Km/L", "201 HP", Assets.userThomas.name, "Thomas", true),
  CarsForSell(Assets.carRenault.name, "Renault KWID", "2 Jan, 2022", "2021", r"$ 1,25,000", "White", "18 Km/L", "201 HP", Assets.userDanish.name, "Danish", false),
  CarsForSell(Assets.carAcura.name, "Acura ILX", "2 Jan, 2022", "2020", r"$ 1,25,000", "White", "18 Km/L", "201 HP", Assets.userThomas.name, "Thomas", true),
  CarsForSell(Assets.carRenault.name, "Renault KWID", "2 Jan, 2022", "2021", r"$ 1,25,000", "White", "18 Km/L", "201 HP", Assets.userDanish.name, "Danish", false)
];
