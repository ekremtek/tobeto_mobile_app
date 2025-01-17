import 'package:flutter/material.dart';
import 'package:tobeto_mobile_app/screens/dashboard_screen/widgets/fixed_appbar.dart';
import 'package:tobeto_mobile_app/screens/screens.dart';

import 'package:tobeto_mobile_app/utils/constant/constants.dart';
import 'package:tobeto_mobile_app/utils/themes/text_style.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FixedAppbar(
        height: ScreenUtil.getHeight(context) * 0.15,
        bottom: TabBar(
          tabAlignment: TabAlignment.start,
          indicatorColor: TobetoColor.purple,
          controller: _tabController,
          dividerHeight: 0,
          isScrollable: true,
          tabs: [
            Tab(icon: Image.asset(ImagePath.personalInformation)),
            Tab(
                icon: Padding(
              padding: EdgeInsets.only(bottom: ScreenPadding.padding10px),
              child: Image.asset(ImagePath.experiences),
            )),
            Tab(icon: Image.asset(ImagePath.education)),
            Tab(icon: Image.asset(ImagePath.competencies)),
            Tab(icon: Image.asset(ImagePath.certificates)),
            Tab(
                icon: Padding(
              padding: EdgeInsets.only(bottom: ScreenPadding.padding2px),
              child: Image.asset(ImagePath.communities),
            )),
            Tab(icon: Image.asset(ImagePath.projectsAndAwards)),
            Tab(icon: Image.asset(ImagePath.socialMedia)),
            Tab(icon: Image.asset(ImagePath.foreignLanguages)),
            Tab(
                icon: Padding(
              padding: EdgeInsets.only(bottom: ScreenPadding.padding4px),
              child: Image.asset(ImagePath.settings),
            )),
          ],
        ),
        title: Text(
          TobetoText.profileEditAppBar,
          style: TobetoTextStyle.poppins(context).captionPurpleBold24,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenPadding.padding12px),
        child: TabBarView(
          controller: _tabController,
          children: const [
            PersonalInformationForm(),
            WorkLife(),
            EducationLife(),
            Competencies(),
            CertificateScreen(),
            ClubCominities(),
            ProjectsPrize(),
            SocialMedia(),
            Languages(),
            Setting(),
          ],
        ),
      ),
    );
  }
}
