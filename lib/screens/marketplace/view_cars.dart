import 'package:app/bloc/delete_my_marketplace_vehicle/delete_my_marketplace_vehicle_bloc.dart';
import 'package:app/bloc/home/add_car/add_car_bloc.dart';
import 'package:app/bloc/home/view_cars/view_car_bloc.dart';
import 'package:app/screens/marketplace/sell_car.dart';
import 'package:app/screens/marketplace/view_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:intl/intl.dart';
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
  int selectedTab = 1;
  List<MyVehicleMarketPlace>? myMarketPlaceVehicle = [];
  List<AllVehicleData>? allVehicle = [];

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ViewCarBloc>(context).add(GetAllVehicle());
    BlocProvider.of<ViewCarBloc>(context).add(GetMyMarketVehicle());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<SellCarBloc, AddCarToSellState>(
      listener: (context, state) {
        if (state is UpdateCarSuccessFully) {
          allVehicle!.clear();
          BlocProvider.of<ViewCarBloc>(context).add(GetAllVehicle());
        }
      },
      child: Container(
        height: CommonMethods.deviceHeight(),
        width: CommonMethods.deviceWidth(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Assets.backImage.name),
          fit: BoxFit.cover,
        )),
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
                      BlocProvider.of<ViewCarBloc>(context).add(GetMyMarketVehicle());
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
            selectedTab == 1
                ? BlocListener<ViewCarBloc, ViewCarState>(
                    listener: (context, state) {},
                    child: BlocBuilder<ViewCarBloc, ViewCarState>(builder: (context, viewCarState) {
                      if (viewCarState is GetAllVehicleLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (viewCarState is GetAllVehicleSuccessfully) {
                        var data = viewCarState.props[0] as List<AllVehicleData>?;

                        allVehicle!.addAll(data!);
                      }
                      return viewCarState is GetAllVehicleLoading
                          ? const Center(child: CircularProgressIndicator())
                          : allVehicle!.isNotEmpty
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
                                      if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                                        if (!viewCarState.isFetchingMore! && viewCarState.hasMoreData! ) {
                                          BlocProvider.of<ViewCarBloc>(context).add(FetchAllVehicle(fetchingMore: true));
                                          BlocProvider.of<ViewCarBloc>(context).add(GetAllVehicle(page: viewCarState.currentPage!.toString()));
                                        }
                                      }
                                      return false;
                                    },
                                    child: Stack(
                                      children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              MediaQuery.removePadding(
                                                context: context,
                                                removeTop: true,
                                                child: ListView.builder(
                                                    itemCount: allVehicle!.length,
                                                    shrinkWrap: true,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      return listItem(allVehicle![index]);
                                                    }),
                                              ),
                                              if (viewCarState.isLoading!) const CircularProgressIndicator()
                                            ],
                                          ),
                                        ),
                                        if (viewCarState.isFetchingMore!)
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
                                    child: const Center(
                                        child: Text(
                                      "No vehicle found",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                  ),
                                );
                    }),
                  )
                : myListedCarView()
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
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colours.darkGray.code,
                            radius: 20.0,
                            backgroundImage: AssetImage(Assets.car.name),
                          ),
                          horizontalSpacer(width: 5.0),
                          Text(
                            "car.sellerName",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: AppStyles.blackSemiW400_1,
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
      ) /*SwipeActionCell(
        key: ObjectKey(car.id),
        trailingActions: */ /*selectedTab == 1
            ? null
            :*/ /*
            <SwipeAction>[
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
                Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(
                    builder: (context) => SellCar(
                          fromEdit: true,
                          myVehicleMarketPlace: car,
                        )));
              },
              color: Colors.black),
        ],
        child:,
      )*/
      ;

  Widget myListItem(MyVehicleMarketPlace car) => SwipeActionCell(
        key: ObjectKey(car.id),
        trailingActions: selectedTab == 0
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
                      BlocProvider.of<DeleteMarketPlaceVehicleBloc>(context).add(DeleteMyVehicleRequested(id: car.id.toString()));
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
                                myVehicle: car,
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

  myListedCarView() {
    return BlocListener<ViewCarBloc, ViewCarState>(listener: (context, state) {
      if (state is GetMyMarketLoading) {}
      if (state is NoMyMarketVehicleFound && state.currentPageMyMarket == null) {}
      if (state is MyMarketPlaceVehicles) {
        myMarketPlaceVehicle!.clear();
        var data = state.props[0] as List<MyVehicleMarketPlace>?;
        myMarketPlaceVehicle!.addAll(data!);
      }
    }, child: BlocBuilder<ViewCarBloc, ViewCarState>(builder: (context, viewCarState) {
      /*  if (viewCarState is GetMyMarketLoading) {
         return const Center(child: CircularProgressIndicator());
      }
*/
      if (viewCarState is GetMyMarketVehicle) {}
      return myMarketPlaceVehicle!.isNotEmpty
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
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                    if (!viewCarState.isFetchingMoreMyMarket! && viewCarState.hasMoreDataMyMarket! && !viewCarState.isLoadingMyMarket!) {
                      BlocProvider.of<ViewCarBloc>(context).add(FetchMyMarketVehicle(fetchingMore: true));
                      BlocProvider.of<ViewCarBloc>(context).add(GetMyMarketVehicle(page: viewCarState.currentPageMyMarket!.toString()));
                    }
                  }
                  return false;
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: BlocListener<DeleteMarketPlaceVehicleBloc, DeleteMarketPlaceVehicleState>(
                              listener: (ctx, state) {
                                if (state is DeletedMyVehicleSuccessfully) {
                                  BlocProvider.of<ViewCarBloc>(context).add(GetMyMarketVehicle());
                                }
                              },
                              child: ListView.builder(
                                  itemCount: myMarketPlaceVehicle!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return myListItem(myMarketPlaceVehicle![index]);
                                  }),
                            ),
                          ),
                          // if (viewCarState.isLoading!) const CircularProgressIndicator()
                        ],
                      ),
                    ),
                    if (viewCarState.isFetchingMoreMyMarket!)
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
                child: const Center(
                    child: Text(
                  "No vehicle found",
                  style: TextStyle(color: Colors.black),
                )),
              ),
            );
    }));
  }
}
