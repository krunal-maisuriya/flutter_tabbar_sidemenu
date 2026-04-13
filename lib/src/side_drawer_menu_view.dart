import 'package:flutter/material.dart';

class SideDrawerMenuView extends StatefulWidget {
  final bool isOpenDrawer;
  final int selectIndex;
  final Color drawerBGColor;
  final Function(int) onItemTap;

  const SideDrawerMenuView({
    super.key,
    required this.isOpenDrawer,
    required this.selectIndex,
    this.drawerBGColor = Colors.white,
    required this.onItemTap,
  });

  @override
  State<SideDrawerMenuView> createState() => _SideDrawerMenuViewState();
}

class _SideDrawerMenuViewState extends State<SideDrawerMenuView> with SingleTickerProviderStateMixin {

  final ScrollController _scrollController = ScrollController();
  late final AnimationController _controller;
  late final Animation<double> _animation;

  final List<String> menus = ["Dashboard", "Search", "Profile", "Setting"];
  int selectedIndex = 0;
  double itemHeight = 60;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(covariant SideDrawerMenuView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isOpenDrawer != oldWidget.isOpenDrawer) {
      if (widget.isOpenDrawer) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }

    if (oldWidget.selectIndex != widget.selectIndex) {
      setState(() {
        selectedIndex = widget.selectIndex;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
        },
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            
            /// Drawer View
            AnimatedBuilder(
              animation: _animation,
              builder: (_, _) {
                final drawerWidth = MediaQuery.of(context).size.width * 0.76;

                return Transform.translate(
                  offset: Offset(-drawerWidth + (drawerWidth * _animation.value), 0),
                  child: SizedBox(
                    width: drawerWidth,
                    child: Container(
                      padding: const EdgeInsets.only(right: 5),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: widget.drawerBGColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                      ),
                      child: SafeArea(
                        bottom: false,
                        child: Stack(
                          children: [

                            /// List View
                            ListView.builder(
                              controller: _scrollController,
                              itemCount: menus.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: index < menus.length - 1
                                        ? Border(bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.2),))
                                        : null,
                                  ),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      setState(() => selectedIndex = index);
                                      widget.onItemTap(index);
                                    },
                                    child: Container(
                                      height: itemHeight,
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Row(
                                        children: [

                                          /// Vertical Indicator
                                          Container(
                                            width: 7,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: selectedIndex == index
                                                  ? Colors.green.shade800
                                                  : Colors.transparent,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight: Radius.circular(15),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 15),

                                          Expanded(
                                            child: Text(
                                              menus[index],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),

                                          Icon(
                                            Icons.circle,
                                            size: 16,
                                            color: selectedIndex == index
                                                ? Colors.green.shade800
                                                : Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}