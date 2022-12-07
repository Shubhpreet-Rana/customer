import 'package:app/model/all_vehicle_model.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/styles/styles.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/headers.dart';

class ViewCarDetails extends StatefulWidget {
  final AllVehicleData car;

  const ViewCarDetails({Key? key, required this.car}) : super(key: key);

  @override
  State<ViewCarDetails> createState() => _ViewCarDetailsState();
}

class _ViewCarDetailsState extends State<ViewCarDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(bottom: false, child: AppHeaders().collapsedHeader(text: AppConstants.marketplace, context: context, backNavigation: true, onFilterClick: () {})),
            verticalSpacer(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 0.0, top: 2.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colours.lightGray.code,
                ),
                child: _listItem(widget.car),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listItem(AllVehicleData car) => Column(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        car.carImage1!,
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
                        "Posted on ${car.createdAt!}",
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
                              car.capacity!.toString(),
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
          Container(
              margin: const EdgeInsets.only(bottom: 20.0, top: 2.0),
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colours.darkGray.code,
                    radius: 20.0,
                    backgroundImage: NetworkImage(car.userImage!),
                  ),
                  horizontalSpacer(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${car.userFirstName}  ${car.userLastName}",
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: AppStyles.blackSemiW400_1,
                      ),
                      verticalSpacer(height: 5.0),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colours.gray.code,
                          ),
                          horizontalSpacer(width: 5.0),
                          Text(
                            car.address!,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: AppStyles.lightText12,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colours.gray.code,
                          ),
                          horizontalSpacer(width: 5.0),
                          Text(
                            car.userMobile!,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: AppStyles.lightText12,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ))
        ],
      );
}
