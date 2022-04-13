import 'package:app/common/assets.dart';
import 'package:app/common/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/constants.dart';
import '../../../common/methods/common.dart';
import '../../../common/styles/styles.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/drop_down.dart';
import '../../../common/ui/headers.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

final List<String> imgList = [Assets.banner.name, Assets.banner.name, Assets.banner.name];

class _HomeTabState extends State<HomeTab> {
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
              bottom: false, child: AppHeaders().collapsedHeader(text: "", context: context, backNavigation: false, onFilterClick: () {})),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: searchBox(controller: searchController)),
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
            decoration: BoxDecoration(
              color: Colours.lightGray.code,
            ),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 4),
                        autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                      ),
                      itemCount: imgList.length,
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                        final data = imgList[itemIndex];
                        return itemHomeSlider(data);
                      },
                    ),
                    verticalSpacer(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                      child: Text(AppConstants.sProviderText, style: AppStyles.blackSemiBold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child: serviceProviders(icon: Assets.periodic.name, text: AppConstants.provider1)),
                          Expanded(child: serviceProviders(icon: Assets.ac.name, text: AppConstants.provider2)),
                          Expanded(child: serviceProviders(icon: Assets.tyre.name, text: AppConstants.provider3)),
                          Expanded(child: serviceProviders(icon: Assets.battery.name, text: AppConstants.provider4)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                      child: Text(AppConstants.bookingText, style: AppStyles.blackSemiBold),
                    ),
                    Container(
                      width: CommonMethods.deviceWidth(),
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bookingHistory(icon: Assets.periodic.name, serviceText: AppConstants.provider1, status: 1, date: '25 Mar, 2022'),
                          bookingHistory(icon: Assets.ac.name, serviceText: AppConstants.provider2, status: 2, date: '19 Mar, 2022'),
                          verticalSpacer(),
                          Container(
                            height: 130.0,
                            width: CommonMethods.deviceWidth(),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                Assets.banner1.name,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          verticalSpacer(),
                          Row(
                            children: [
                              Expanded(child: rowButton(bkColor: Colours.textBlack.code, text: AppConstants.addToSell)),
                              horizontalSpacer(),
                              Expanded(child: rowButton(bkColor: Colours.blue.code, text: AppConstants.viewCards)),
                            ],
                          ),
                          verticalSpacer(height: 100),
                        ],
                      ),
                    ),
                  ],
                )),
          ))
        ],
      )),
    );
  }

  Widget bookingHistory({required String icon, required String serviceText, required String date, required int status}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: SvgPicture.asset(
                        icon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  horizontalSpacer(width: 10.0),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          serviceText,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: AppStyles.blackSemiW400_1,
                        ),
                        Text(
                          "On " + date,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: AppStyles.lightText,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              status == 1 ? AppConstants.active : AppConstants.completed,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: status == 1 ? AppStyles.textGreen : AppStyles.textBlue,
            )
          ],
        ),
      );

  Widget serviceProviders({required String icon, required String text}) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 25.0,
            fit: BoxFit.cover,
          ),
          verticalSpacer(height: 10.0),
          Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: AppStyles.blackSemiW400,
          )
        ],
      );

  Widget itemHomeSlider(String data) {
    return Image.asset(
      data,
      fit: BoxFit.cover,
    );
  }
}
