import 'package:common/common.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:about/about_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

class MainPage extends StatelessWidget {
  static const routeName = '/main_page';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    int page = (context.watch<BottomNavigationBloc>().state
            is BottomNavigationPage)
        ? (context.read<BottomNavigationBloc>().state as BottomNavigationPage)
            .page
        : 0;

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: _buildBody(context, page: page),
      bottomNavigationBar: _bottomNavBar(context, page: page),
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required int page,
  }) {
    switch (page) {
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

  Widget _bottomNavBar(
    BuildContext context, {
    required int page,
  }) {
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
            isActive: page == 0 ? true : false,
            onTap: () {
              context
                  .read<BottomNavigationBloc>()
                  .add(const BottomNavigationSetPage(page: 0));
            },
          ),
          _bottomNavBarItem(
            context,
            iconData: IconlyLight.play,
            title: "TV Shows",
            isActive: page == 1 ? true : false,
            onTap: () {
              context
                  .read<BottomNavigationBloc>()
                  .add(const BottomNavigationSetPage(page: 1));
            },
          ),
          _bottomNavBarItem(
            context,
            iconData: IconlyLight.bookmark,
            title: "Watchlist",
            isActive: page == 2 ? true : false,
            onTap: () {
              context
                  .read<BottomNavigationBloc>()
                  .add(const BottomNavigationSetPage(page: 2));
            },
          ),
          _bottomNavBarItem(
            context,
            iconData: IconlyLight.info_square,
            title: "About",
            isActive: page == 3 ? true : false,
            onTap: () {
              context
                  .read<BottomNavigationBloc>()
                  .add(const BottomNavigationSetPage(page: 3));
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
