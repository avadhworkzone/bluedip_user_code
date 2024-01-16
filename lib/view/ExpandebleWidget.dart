import 'package:bluedip_user/view/ExpandablePageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import 'home/resto_details/RestoDetailAmenitiesTab.dart';
import 'home/resto_details/RestoDetailMenuTab.dart';
import 'home/resto_details/RestoDetailOfferTab.dart';
import 'home/resto_details/RestoDetailReviewTab.dart';

class ExpandebleWidget extends StatefulWidget {
  const ExpandebleWidget({Key? key}) : super(key: key);

  @override
  State<ExpandebleWidget> createState() => _ExpandebleWidgetState();
}

class _ExpandebleWidgetState extends State<ExpandebleWidget>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  Widget? _tabBarView;
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tabBarView = TabBarView(children: [
      DemoTab(parentController: scrollController),
      DemoTab(parentController: scrollController),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: scrollController,
          physics: ScrollPhysics(parent: PageScrollPhysics()),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                    [Container(height: 300, color: Colors.blue)]),
              ),
            ];
          },
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                Container(
                  child: TabBar(labelColor: Colors.grey, tabs: [
                    Tab(
                      text: 'One',
                    ),
                    Tab(
                      text: 'two',
                    )
                  ]),
                ),
                Expanded(
                  child: Container(child: _tabBarView),
                ),
              ],
            ),
          )),
    );
  }
}

class DemoTab extends StatefulWidget {
  DemoTab({required this.parentController});

  final ScrollController parentController;

  DemoTabState createState() => DemoTabState();
}

class DemoTabState extends State<DemoTab>
    with AutomaticKeepAliveClientMixin<DemoTab> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  late ScrollController _scrollController;

  late ScrollPhysics ph;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      var innerPos = _scrollController.position.pixels;
      var maxOuterPos = widget.parentController.position.maxScrollExtent;
      var currentOutPos = widget.parentController.position.pixels;

      if (innerPos >= 0 && currentOutPos < maxOuterPos) {
        //print("parent pos " + currentOutPos.toString() + "max parent pos " + maxOuterPos.toString());
        widget.parentController.position.jumpTo(innerPos + currentOutPos);
      } else {
        var currenParentPos = innerPos + currentOutPos;
        widget.parentController.position.jumpTo(currenParentPos);
      }
    });

    widget.parentController.addListener(() {
      var currentOutPos = widget.parentController.position.pixels;
      if (currentOutPos <= 0) {
        _scrollController.position.jumpTo(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: UniqueKey(),
      controller: _scrollController,
      itemBuilder: (b, i) {
        return Container(
          height: 50,
          color: Colors.green,
          margin: EdgeInsets.only(bottom: 3),
          child: Text(
            i.toString(),
          ),
        );
      },
      itemCount: 5,
    );
  }
}
