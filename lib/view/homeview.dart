import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dezeer/constants.dart';
import 'package:music_dezeer/viewmodel/home/cubit/home_cubit.dart';
import 'package:music_dezeer/widgets/custom_text.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: CustomText(
                msg: "Music Dezeer",
              ),
              centerTitle: true,
            ),
            body: cubit.pages[cubit.currentPage],
            bottomNavigationBar: ConvexAppBar(
              backgroundColor: primaryColor,
              elevation: 0,
              style: TabStyle.textIn,
              initialActiveIndex: cubit.currentPage,
              onTap: (index) {
                cubit.changePage(index);
              },
              items: [
                TabItem(icon: Icons.album, title: 'Albums'),
                TabItem(icon: Icons.people, title: 'Artists'),
                TabItem(icon: Icons.track_changes_rounded, title: 'Tracks'),
              ],
            ));
      },
    );
  }
}
