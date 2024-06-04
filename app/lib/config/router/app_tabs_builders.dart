part of './app_tabs_router.dart';

MainAppBar _appBarBuilder(BuildContext _, TabsRouter tabsRouter) {
  switch (tabsRouter.activeIndex) {
    default:
      return Container() as MainAppBar;
  }
}

AppNavigationBar _bottomNavigationBuilder(
  BuildContext _,
  TabsRouter tabsRouter,
) {
  return AppNavigationBar(
    selectedIndex: tabsRouter.activeIndex,
    onTap: (index) {
      tabsRouter.setActiveIndex(index);
    },
  );
}
