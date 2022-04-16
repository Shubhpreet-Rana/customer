import 'package:app/common/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../common/methods/common.dart';
import '../../../common/styles/styles.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/drop_down.dart';
import '../../../common/ui/headers.dart';

class CarTab extends StatefulWidget {
  const CarTab({Key? key}) : super(key: key);

  @override
  State<CarTab> createState() => _CarTabState();
}

class _CarTabState extends State<CarTab> {
  TextEditingController searchController = TextEditingController();

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
          SafeArea(
              bottom: false,
              child: AppHeaders().collapsedHeader(
                  text: AppConstants.sProviderText,
                  context: context,
                  backNavigation: false,
                  onFilterClick: () {
                    CommonMethods().openFilters(context);
                  })),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: searchBox(controller: searchController, hintText: "service")),
                horizontalSpacer(),
                Expanded(
                  child: AppDropdown(
                    bgColor: Colours.blue.code,
                    items: AppConstants.serviceItems,
                    selectedItem: AppConstants.serviceItems[0],
                    height: 44.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                  width: CommonMethods.deviceWidth(),
                  height: CommonMethods.deviceHeight(),
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colours.lightGray.code,
                  ),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index % 2 == 0) {
                            return listItem(
                                image: Assets.service.name,
                                serviceType: "Basic Service",
                                joinDate: "15 Mar, 2021",
                                services: ['AC Gas Change', 'Gasoline', 'Cooling Test'],
                                rating: 5);
                          } else {
                            return listItem(
                                image: Assets.service1.name,
                                serviceType: "Basic Service",
                                joinDate: "15 Mar, 2021",
                                services: ['AC Gas Change', 'Gasoline', 'Cooling Test']);
                          }
                        }),
                  )))
        ],
      )),
    );
  }

  Widget listItem(
          {required String image,
          required String serviceType,
          required String joinDate,
          required List<String> services,
          double rating = 4}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 100.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      image,
                      fit: BoxFit.fill,
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
                      Text(
                        serviceType,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppStyles.blackSemiBold,
                      ),
                      Text(
                        "Joined " + joinDate,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppStyles.lightText12,
                      ),
                      ListView.builder(
                          itemCount: services.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.blueDot.name,
                                  height: 8.0,
                                  width: 8.0,
                                ),
                                horizontalSpacer(width: 8.0),
                                Text(
                                  services[index],
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.blackText,
                                ),
                              ],
                            );
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0, top: 2.0),
            padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,left: 4.0,right: 4.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RatingBarIndicator(
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Color(0xFFF1C21C),
                            ),
                        rating: rating,
                        itemSize: 18.0),
                    /* RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 18.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color(0xFFF1C21C),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),*/
                    Text(rating.toString())
                  ],
                ),
                Row(
                  children: [
                    rowButton(
                        bkColor: Colours.lightWhite.code,
                        textColor: Colours.blue.code,
                        text: AppConstants.location,
                        paddingHorizontal: 8.0,
                        paddingVertical: 7.0),
                    horizontalSpacer(),
                    rowButton(bkColor: Colours.blue.code, text: AppConstants.bookNow, paddingHorizontal: 8.0, paddingVertical: 7.0),
                  ],
                ),
              ],
            ),
          )
        ],
      );
}
