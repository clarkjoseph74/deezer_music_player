import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dezeer/viewmodel/artist/artist_cubit.dart';
import 'package:music_dezeer/viewmodel/home/cubit/home_cubit.dart';
import 'package:music_dezeer/widgets/custom_text.dart';

class TracksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArtistCubit, ArtistState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ArtistCubit.get(context);
        return state is GetATracksLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubit.tapTracks.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2.5 / 3,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                cubit.tapTracks[index]
                                                    .songArtist.picture!))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.amber,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: BlocConsumer<HomeCubit, HomeState>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        var homeCubit = HomeCubit.get(context);
                                        return GestureDetector(
                                          onTap: () {
                                            homeCubit.togglrPlayer(
                                                url: cubit
                                                    .tapTracks[index].preview,
                                                track: cubit.tapTracks[index]);
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.pink,
                                            child: Icon(
                                              cubit.tapTracks[index].icon,
                                              color: Colors.white,
                                              size: 35,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              CustomText(
                                msg: cubit.tapTracks[index].title,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }
}
