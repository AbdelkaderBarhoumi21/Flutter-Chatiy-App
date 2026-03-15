import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/utils/constans/app_colors.dart';
import 'package:flutter_chatiy_app/core/widgets/buttons/glowing_actions_buttons.dart';
import 'package:flutter_chatiy_app/features/navigation_menu/widgets/custom_navigation_bar_item.dart';

class CustomNavigationBarView extends StatefulWidget {
  const CustomNavigationBarView({required this.onItemSelected, super.key});
  final ValueChanged<int> onItemSelected;

  @override
  State<CustomNavigationBarView> createState() =>
      _CustomNavigationBarViewState();
}

class _CustomNavigationBarViewState extends State<CustomNavigationBarView> {
  int selectedIndex = 0;
  void _handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomNavigationBarItem(
                label: 'Messages',
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                index: 0,
                onItemTap: _handleItemSelected,
                isSelected: selectedIndex == 0,
              ),
              CustomNavigationBarItem(
                label: 'Notifications',
                icon: CupertinoIcons.bell_solid,
                index: 1,
                onItemTap: _handleItemSelected,
                isSelected: selectedIndex == 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GlowingActionButton(
                  color: AppColors.secondary,
                  icon: CupertinoIcons.add,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const Dialog(
                        child: AspectRatio(
                          aspectRatio: 8 / 7,
                          child: Text('Data'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              CustomNavigationBarItem(
                label: 'Calls',
                icon: CupertinoIcons.phone_fill,
                index: 2,
                onItemTap: _handleItemSelected,
                isSelected: selectedIndex == 2,
              ),
              CustomNavigationBarItem(
                label: 'Contacts',
                icon: CupertinoIcons.person_2_fill,
                index: 3,
                onItemTap: _handleItemSelected,
                isSelected: selectedIndex == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
