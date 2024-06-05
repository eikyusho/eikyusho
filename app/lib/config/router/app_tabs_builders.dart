part of './app_tabs_router.dart';

MainAppBar _appBarBuilder(BuildContext _, TabsRouter tabsRouter) {
  switch (tabsRouter.activeIndex) {
    case 0:
      return const DiscoverPageAppBar();
    default:
      return const DiscoverPageAppBar();
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
