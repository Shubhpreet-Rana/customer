/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:service_provider/screens/marketplace/sell_car.dart';
import 'package:service_provider/screens/marketplace/view_details.dart';

import '../../common/assets.dart';
import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/styles/styles.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/headers.dart';

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

  Widget listItem(CarsForSell car) => SwipeActionCell(
        key: ObjectKey(car.id),
        trailingActions: selectedTab == 1
            ? null
            : <SwipeAction>[
                SwipeAction(
                    title: "",
                    style: const TextStyle(color: Colors.white),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onTap: (CompletionHandler handler) async {
                      setState(() {});
                    },
                    color: Colors.red),
                SwipeAction(
                    title: "",
                    style: const TextStyle(color: Colors.white),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onTap: (CompletionHandler handler) async {
                      Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(builder: (context) =>  SellCar(fromEdit: true,)));
                    },
                    color: Colors.black),
              ],
        child: Column(
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
                                */ /* Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(
                                    builder: (context) => const MyAppMap(
                                          showPickUp: false,
                                        )));*/ /*
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
        ),
      );
}*/

/*
class CarsForSell {
  final String id;
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

  CarsForSell(this.id, this.image, this.title, this.postedDate, this.year, this.price, this.color, this.mileage, this.capacity, this.sellerImage, this.sellerName, this.carOwner);
}

List<CarsForSell> cars = [
  CarsForSell("1", Assets.carAcura.name, "Acura ILX", "2 Jan, 2022", "2020", r"$ 1,25,000", "White", "18 Km/L", "201 HP", Assets.userThomas.name, "Thomas", true),
  CarsForSell("2", Assets.carRenault.name, "Renault KWID", "2 Jan, 2022", "2021", r"$ 1,25,000", "White", "18 Km/L", "201 HP", Assets.userDanish.name, "Danish", false),
  CarsForSell("3", Assets.carAcura.name, "Acura ILX", "2 Jan, 2022", "2020", r"$ 1,25,000", "White", "18 Km/L", "201 HP", Assets.userThomas.name, "Thomas", true),
  CarsForSell("4", Assets.carRenault.name, "Renault KWID", "2 Jan, 2022", "2021", r"$ 1,25,000", "White", "18 Km/L", "201 HP", Assets.userDanish.name, "Danish", false)
];
*/

import 'package:app/screens/marketplace/sell_car.dart';
import 'package:app/screens/marketplace/view_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:intl/intl.dart';
import '../../bloc/delete_my_marketplace_vehicle/delete_my_marketplace_vehicle_bloc.dart';
import '../../bloc/home/add_car/add_car_bloc.dart';
import '../../bloc/home/view_cars/view_car_bloc.dart';
import '../../common/assets.dart';
import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/styles/styles.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/headers.dart';
import '../../model/all_vehicle_model.dart';
import '../../model/my_marketplace_vehicle.dart';
import '../maps/maps_page.dart';

class ViewCars extends StatefulWidget {
  const ViewCars({Key? key}) : super(key: key);

  @override
  State<ViewCars> createState() => _ViewCarsState();
}

class _ViewCarsState extends State<ViewCars> {
  int _selectedTab = 1;
  final List<MyVehicleMarketPlace> _myMarketPlaceVehicle = [];
  final List<AllVehicleData> _allVehicle = [];
  bool _isMoreFetchAllVehicleLoading = false;
  bool _isMoreFetchMyMarketVehicleLoading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllVehicleBloc>(context).add(const AllVehicleRequestEvent(isFetchingMoreLoadingState: false, isInitialLoadingState: true, isPaginationStartFromFirstPage: true));
    BlocProvider.of<MyMarketVehicleBloc>(context).add(const MyMarketVehicleRequestEvent(isInitialLoadingState: true, isFetchingMoreLoadingState: false, isPaginationStartFromFirstPage: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<SellCarBloc, AddCarToSellState>(
      listener: (context, state) {
        if (state is UpdateCarSuccessFully) {
          _allVehicle.clear();
          BlocProvider.of<AllVehicleBloc>(context).add(const AllVehicleRequestEvent(isFetchingMoreLoadingState: false, isInitialLoadingState: true, isPaginationStartFromFirstPage: true));
        }
      },
      child: Container(
        height: CommonMethods.deviceHeight(),
        width: CommonMethods.deviceWidth(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.backImage.name),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              bottom: false,
              child: AppHeaders().collapsedHeader(
                text: AppConstants.marketplace,
                context: context,
                backNavigation: true,
                onFilterClick: () {},
              ),
            ),
            verticalSpacer(),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _selectedTab = 1;
                    });
                  },
                  child: Text(
                    AppConstants.allCars,
                    textAlign: TextAlign.center,
                    style: _selectedTab == 1 ? AppStyles.whiteText : AppStyles.blueLightText,
                  ),
                )),
                horizontalSpacer(width: 10.0),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        _selectedTab = 2;
                      });
                    },
                    child: Text(
                      AppConstants.myListedCars,
                      textAlign: TextAlign.center,
                      style: _selectedTab == 2 ? AppStyles.whiteText : AppStyles.blueLightText,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpacer(height: 10.0),
            _selectedTab == 1 ? _allCarsView() : _myListedCarView()
          ],
        ),
      ),
    ));
  }

  Widget listItem(AllVehicleData car) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(10),
                  topLeft: const Radius.circular(10),
                  bottomRight: Radius.circular(_selectedTab == 2 ? 10 : 0),
                  bottomLeft: Radius.circular(_selectedTab == 2 ? 10 : 0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: car.carImage1!,
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
                            car.brandName!,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: AppStyles.blackSemiBold,
                          ),
                          Text(
                            car.manufacturingYear ?? "",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: AppStyles.lightText,
                          )
                        ],
                      ),
                      Text(
                        "Posted on " "  ${DateFormat('yyyy-MM-dd ').format(car.createdAt!)}",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppStyles.lightText12,
                      ),
                      verticalSpacer(height: 5.0),
                      Text(
                        car.price!,
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
                              car.color!,
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
                              car.mileage!,
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
                              car.capacity.toString(),
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
          _selectedTab == 1
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
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colours.darkGray.code,
                            radius: 20.0,
                            backgroundImage: NetworkImage(car.userImage!),
                          ),
                          horizontalSpacer(width: 5.0),
                          Expanded(
                            child: Text(
                              "${car.userFirstName} ${car.userLastName}",
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.blackSemiW400_1,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(
                                      builder: (context) => const MyAppMap(
                                            showPickUp: false,
                                          )));
                                },
                                child: rowButton(bkColor: Colours.lightWhite.code, textColor: Colours.blue.code, text: AppConstants.location1, paddingHorizontal: 8.0, paddingVertical: 7.0)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(builder: (context) => ViewCarDetails(car: car)));
                                },
                                child: rowButton(bkColor: Colours.blue.code, text: AppConstants.details, paddingHorizontal: 8.0, paddingVertical: 7.0)),
                          )
                        ],
                      ),
                    )
                  ]))
              : const SizedBox.shrink()
        ],
      );

  Widget _myListItem(MyVehicleMarketPlace car) {
    DeleteMarketPlaceVehicleState state = BlocProvider.of<DeleteMarketPlaceVehicleBloc>(context).state;
    if(state is DeleteVehicleLoadingState){
      return const Center(child: CircularProgressIndicator());
    }
    return  SwipeActionCell(
      key: ObjectKey(car.id),
      trailingActions: _selectedTab == 0
          ? null
          : <SwipeAction>[
              SwipeAction(
                  title: "",
                  style: const TextStyle(color: Colors.white),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onTap: (CompletionHandler handler) async {
                    BlocProvider.of<DeleteMarketPlaceVehicleBloc>(context).add(
                      DeleteMyVehicleRequested(id: car.id.toString()),
                    );
                  },
                  color: Colors.red),
              SwipeAction(
                  title: "",
                  style: const TextStyle(color: Colors.white),
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onTap: (CompletionHandler handler) async {
                    Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(
                        builder: (context) => SellCar(
                              fromEdit: true,
                              myVehicleMarketPlace: car,
                            )));
                  },
                  color: Colors.black),
            ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(10),
                  topLeft: const Radius.circular(10),
                  bottomRight: Radius.circular(_selectedTab == 2 ? 10 : 0),
                  bottomLeft: Radius.circular(_selectedTab == 2 ? 10 : 0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: car.carImage1!,
                        fit: BoxFit.cover,
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
                            car.brandName!,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: AppStyles.blackSemiBold,
                          ),
                          Text(
                            car.manufacturingYear!,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: AppStyles.lightText,
                          )
                        ],
                      ),
                      Text(
                        "Posted on " " ${DateFormat('yyyy-MM-dd ').format(car.createdAt!)}",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppStyles.lightText12,
                      ),
                      verticalSpacer(height: 5.0),
                      Text(
                        car.price!,
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
                              car.color!,
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
                              car.mileage!,
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
                              car.capacity.toString(),
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
        ],
      ),
    );
  }

  Widget _myListedCarView() {
    return BlocBuilder<MyMarketVehicleBloc, MyMarketVehicleState>(
      builder: (context, state) {
        _isMoreFetchMyMarketVehicleLoading = false;
        if (state is MyMarketVehicleLoadingState && state.isInitialLoadingState) {
          return Expanded(
            child: Container(
              height: CommonMethods.deviceHeight(),
              width: CommonMethods.deviceWidth(),
              alignment: Alignment.center,
              color: Colors.white,
              child: const CircularProgressIndicator(),
            ),
          );
        }
        if (state is MyMarketVehicleLoadedState && state.myMarketVehicle.isNotEmpty) {
          _myMarketPlaceVehicle.addAll(state.myMarketVehicle);
        }
        return _myMarketPlaceVehicle.isNotEmpty
            ? Expanded(
                child: Container(
                width: CommonMethods.deviceWidth(),
                height: CommonMethods.deviceHeight(),
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0, top: 20.0),
                decoration: BoxDecoration(
                  color: Colours.lightGray.code,
                ),
                child: NotificationListener(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                        !_isMoreFetchMyMarketVehicleLoading &&
                        state is! MyMarketVehicleLoadingState &&
                        (state is MyMarketVehicleLoadedState && !state.isLastPage)) {
                      _isMoreFetchMyMarketVehicleLoading = true;
                      BlocProvider.of<MyMarketVehicleBloc>(context)
                          .add(const MyMarketVehicleRequestEvent(isPaginationStartFromFirstPage: false, isInitialLoadingState: false, isFetchingMoreLoadingState: true));
                    }
                    return false;
                  },
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              itemCount: _myMarketPlaceVehicle.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return _myListItem(_myMarketPlaceVehicle[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                      if (state is MyMarketVehicleLoadingState && state.isFetchingMoreLoadingState)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: SpinKitCircle(
                                color: Colors.black,
                                size: 60,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ))
            : Expanded(
                child: Container(
                  width: CommonMethods.deviceWidth(),
                  height: CommonMethods.deviceHeight(),
                  decoration: BoxDecoration(
                    color: Colours.lightGray.code,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "No vehicle found",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<MyMarketVehicleBloc>(context)
                                .add(const MyMarketVehicleRequestEvent(isFetchingMoreLoadingState: false, isInitialLoadingState: true, isPaginationStartFromFirstPage: true));
                          },
                          child: const Text("Refresh"))
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget _allCarsView() {
    return BlocBuilder<AllVehicleBloc, AllVehicleState>(
      builder: (context, state) {
        _isMoreFetchAllVehicleLoading = false;
        if (state is AllVehicleLoadingState && state.isInitialLoadingState) {
          return Expanded(
            child: Container(
              height: CommonMethods.deviceHeight(),
              width: CommonMethods.deviceWidth(),
              alignment: Alignment.center,
              color: Colors.white,
              child: const CircularProgressIndicator(),
            ),
          );
        }
        if (state is AllVehicleLoadedState && state.allVehicleList.isNotEmpty) {
          _allVehicle.addAll(state.allVehicleList);
        }
        return _allVehicle.isNotEmpty
            ? Expanded(
                child: Container(
                  width: CommonMethods.deviceWidth(),
                  height: CommonMethods.deviceHeight(),
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0, top: 20.0),
                  decoration: BoxDecoration(
                    color: Colours.lightGray.code,
                  ),
                  child: NotificationListener(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                          !_isMoreFetchAllVehicleLoading &&
                          state is! AllVehicleLoadingState &&
                          (state is AllVehicleLoadedState && !state.isLastPage)) {
                        _isMoreFetchAllVehicleLoading = true;
                        BlocProvider.of<AllVehicleBloc>(context).add(
                          const AllVehicleRequestEvent(isInitialLoadingState: false, isFetchingMoreLoadingState: true, isPaginationStartFromFirstPage: false),
                        );
                      }
                      return false;
                    },
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                  itemCount: _allVehicle.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return listItem(_allVehicle[index]);
                                  }),
                            ],
                          ),
                        ),
                        if (state is AllVehicleLoadingState && state.isFetchingMoreLoadingState)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: SpinKitCircle(
                                  color: Colors.black,
                                  size: 60,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              )
            : Expanded(
                child: Container(
                  width: CommonMethods.deviceWidth(),
                  height: CommonMethods.deviceHeight(),
                  decoration: BoxDecoration(
                    color: Colours.lightGray.code,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "No vehicle found",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AllVehicleBloc>(context)
                                .add(const AllVehicleRequestEvent(isFetchingMoreLoadingState: false, isInitialLoadingState: true, isPaginationStartFromFirstPage: true));
                          },
                          child: const Text("Refresh"))
                    ],
                  ),
                ),
              );
      },
    );
  }
}
