import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/activity/activiti_screen.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/home/home_screen.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/menu/menu_screen.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/widraw/widraw_screen.dart';
import 'package:flutter/material.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'nav_bar_item_widget.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> screens = [
    const HomeScreen(),
    const ActivitiScreen(),
    WithdrawScreen(),
    const MenuScreen(),
  ];

  int currentIndex = 0;
 Future<bool> _onWillPop() async {
    if (currentIndex != 0) {
      setState(() {
        currentIndex = 0;
      });
      return false;
    } else {
      return true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: _onWillPop,
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: MyColor.colorWhite, boxShadow: [BoxShadow(color: Color.fromARGB(25, 0, 0, 0), offset: Offset(-2, -2), blurRadius: 2)]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavBarItem(
                    key: const Key('0'),
                    label: MyStrings.home,
                    imagePath: MyImages.home,
                    index: 0,
                    isSelected: currentIndex == 0,
                    press: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    }),
                NavBarItem(
                    key: const Key('1'),
                    label: MyStrings.activity,
                    imagePath: MyImages.activity,
                    index: 1,
                    isSelected: currentIndex == 1,
                    press: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    }),
                NavBarItem(
                    key: const Key('2'),
                    label: MyStrings.withdrawMoney,
                    imagePath: MyImages.withdraw,
                    index: 2,
                    isSelected: currentIndex == 2,
                    press: () {
                      setState(() {
                        currentIndex = 2;
                      });
                    }),
                NavBarItem(
                    key: const Key('3'),
                    label: MyStrings.menu,
                    imagePath: MyImages.menu,
                    index: 3,
                    isSelected: currentIndex == 3,
                    press: () {
                      setState(() {
                        currentIndex = 3;
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
