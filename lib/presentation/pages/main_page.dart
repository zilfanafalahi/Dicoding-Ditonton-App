import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/presentation/pages/about_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/movies/movies_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/tv_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/watchlist_page.dart';
import 'package:dicoding_ditonton_app/presentation/provider/bottom_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  static const routeName = '/main_page';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: _buildBody(context),
      bottomNavigationBar: _bottomNavBar(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    BottomNavigationProvider provider =
        Provider.of<BottomNavigationProvider>(context);

    switch (provider.page) {
      case 0:
        return const MoviesPage();
      case 1:
        return const TvPage();
      case 2:
        return const WatchlistPage();
      case 3:
        return const AboutPage();
      default:
        return const MoviesPage();
    }
  }

  Widget _bottomNavBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhiteColor,
        border: Border(
          top: BorderSide(
            width: 0.2,
            color: kPrimaryColor,
          ),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _bottomNavBarItem(
            context,
            iconData: IconlyLight.ticket,
            title: "Movies",
            isActive: context.read<BottomNavigationProvider>().page == 0
                ? true
                : false,
            onTap: () {
              context.read<BottomNavigationProvider>().setPage(0);
            },
          ),
          _bottomNavBarItem(
            context,
            iconData: IconlyLight.play,
            title: "TV Shows",
            isActive: context.read<BottomNavigationProvider>().page == 1
                ? true
                : false,
            onTap: () {
              context.read<BottomNavigationProvider>().setPage(1);
            },
          ),
          _bottomNavBarItem(
            context,
            iconData: IconlyLight.bookmark,
            title: "Watchlist",
            isActive: context.read<BottomNavigationProvider>().page == 2
                ? true
                : false,
            onTap: () {
              context.read<BottomNavigationProvider>().setPage(2);
            },
          ),
          _bottomNavBarItem(
            context,
            iconData: IconlyLight.info_square,
            title: "About",
            isActive: context.read<BottomNavigationProvider>().page == 3
                ? true
                : false,
            onTap: () {
              context.read<BottomNavigationProvider>().setPage(3);
            },
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBarItem(
    BuildContext context, {
    required IconData iconData,
    required String title,
    required bool isActive,
    required Function()? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isActive
                ? ClipOval(
                    child: Container(
                      height: 4,
                      width: 4,
                      color: kPrimaryColor,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 8,
            ),
            Icon(
              iconData,
              color: isActive ? kPrimaryColor : kGreyColor,
              size: 24,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              title,
              style: isActive
                  ? kTextTheme.overline!.apply(
                      color: kPrimaryColor,
                    )
                  : kTextTheme.overline!.apply(
                      color: kGreyColor,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
