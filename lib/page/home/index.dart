import 'package:flutter/material.dart';
import 'package:flutter_medical_beauty/common/style/colours.dart';
import 'package:flutter_medical_beauty/component/sliver/SliverPersisteneHeaderDelegate.dart';
import 'package:flutter_medical_beauty/page/home/navigation.dart';
import 'package:flutter_medical_beauty/page/home/banner.dart';
import 'package:flutter_medical_beauty/page/home/feature.dart';
import 'package:flutter_medical_beauty/page/home/position.dart';
import 'package:flutter_medical_beauty/page/home/custom_sliver_tab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_medical_beauty/page/home/tabview/recommend.dart';
import 'package:flutter_medical_beauty/store/data/index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        AutomaticKeepAliveClientMixin<HomePage>,
        SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> tabs = home_tabs.map((item) => Tab(text: item)).toList();

  final List<Widget> tabViewList = [RecommendPage(), RecommendPage(), RecommendPage(),RecommendPage(),RecommendPage(),RecommendPage()];


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: _headerSliverBuilder,
        body: TabBarView(physics: BouncingScrollPhysics(), controller: _tabController ,children: tabViewList),
      ),
    );
  }

  List<Widget> _headerSliverBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverPersistentHeader(
        pinned: true,
        delegate: CustomSliverPersistentHeaderDelegate(
            max: ScreenUtil().setHeight(44),
            min: ScreenUtil().setHeight(44),
            child: NavigationPage()),
      ),
      SliverToBoxAdapter(child: BannerPage()),
      SliverToBoxAdapter(child: SizedBox(height: 12)),
      SliverFeaturePage(),
      SliverToBoxAdapter(child: PositionPage()),
      SliverToBoxAdapter(
        child: Container(
          color: Colours.workspace,
          width: double.infinity,
          height: 20,
        ),
      ),
      SliverPersistentTabBarPage(tabs: tabs, tabController: _tabController,),
    ];
  }
}
