import 'package:app/common/assets.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/methods/custom_storage.dart';
import 'package:app/screens/registration/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/profile/view/profile_bloc.dart';
import '../../../common/colors.dart';
import '../../../common/methods/common.dart';
import '../../../common/styles/styles.dart';
import '../../../common/ui/avatar.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/headers.dart';
import '../../profile/edit_options.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(ProfileFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProfileError) {
          return Center(child: Text(state.message));
        }
        if (state is ProfileLoaded) {
          return BackgroundImage(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(bottom: false, child: AppHeaders().collapsedHeader(text: AppConstants.myProfile, context: context, backNavigation: false, onFilterClick: () {})),
              Padding(padding: const EdgeInsets.only(left: 45.0, top: 2.0), child: Text(("Joined on 30 Jan, 2021"), style: AppStyles.whiteText)),
              verticalSpacer(
                height: 10.0,
              ),
              Expanded(
                  child: Container(
                width: CommonMethods.deviceWidth(),
                height: CommonMethods.deviceHeight(),
                padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 5.0, top: 40.0),
                decoration: BoxDecoration(
                  color: Colours.lightGray.code,
                ),
                child: Column(
                  children: [
                    Avatar(
                      radius: 50.0,
                      isCamera: false,
                      fromUrl: true,
                      imagePath: state.userProfile.user!.userImage!,
                      onSelect: () {},
                    ),
                    verticalSpacer(height: 30.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            AppConstants.fNameHint + ":",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: AppStyles.lightText,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            state.userProfile.user!.firstName ?? "",
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            style: AppStyles.blackSemiW400_1,
                          ),
                        )
                      ],
                    ),
                    verticalSpacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            AppConstants.lNameHint + ":",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: AppStyles.lightText,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            state.userProfile.user!.lastName ?? "",
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: AppStyles.blackSemiW400_1,
                          ),
                        )
                      ],
                    ),
                    verticalSpacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            AppConstants.emailHint + ":",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: AppStyles.lightText,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            state.userProfile.user!.email ?? "",
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            style: AppStyles.blackSemiW400_1,
                          ),
                        )
                      ],
                    ),
                    verticalSpacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            AppConstants.mobileHint + ":",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: AppStyles.lightText,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            state.userProfile.user!.mobile ?? "",
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: AppStyles.blackSemiW400_1,
                          ),
                        )
                      ],
                    ),
                    verticalSpacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            AppConstants.genderHint + ":",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: AppStyles.lightText,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            state.userProfile.user!.getGenderText,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: AppStyles.blackSemiW400_1,
                          ),
                        )
                      ],
                    ),
                    verticalSpacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            AppConstants.addressHint + ":",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: AppStyles.lightText,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            state.userProfile.user!.address ?? "",
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            style: AppStyles.blackSemiW400_1,
                          ),
                        )
                      ],
                    ),
                    //verticalSpacer(height: 50.0),
                    const Spacer(),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(builder: (context) => const EditOptions()));
                        },
                        child: appButton(bkColor: Colours.blue.code, text: AppConstants.edit, height: 50.0)),
                    verticalSpacer(),
                    GestureDetector(
                      onTap: () {
                        PreferenceUtils().clearAllPreferences();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        AppConstants.logout,
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: AppStyles.redTextW500,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ))
            ],
          ));
        }
        return Container();
      }),
    );
  }
}
