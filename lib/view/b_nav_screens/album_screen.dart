import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dezeer/view/secondery_view/album_details.dart';
import 'package:music_dezeer/viewmodel/home/cubit/home_cubit.dart';
import 'package:music_dezeer/widgets/common_functions.dart';
import 'package:music_dezeer/widgets/custom_text.dart';

class AlbumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return state is GetAlbumsLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                  child: Container(
                      child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.5 / 3),
                    itemCount: cubit.albums.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(
                                context: context,
                                widget: AlbumDetails(
                                  albumModel: cubit.albums[index],
                                ));
                            cubit.getAlbumTracks(
                                baseUrl: cubit.albums[index].tracklist);
                            print(cubit.albums[index].tracklist);
                          },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 135,
                                  width: 135,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            cubit.albums[index].cover),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Flexible(
                                  child: CustomText(
                                    msg: cubit.albums[index].artist.name,
                                    color: Colors.red,
                                  ),
                                ),
                                Flexible(
                                  child: CustomText(
                                      msg: cubit.albums[index].title),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
                ),
              );
      },
    );
  }
}
