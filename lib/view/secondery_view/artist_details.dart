import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:music_dezeer/data/models/artist_model.dart';
import 'package:music_dezeer/viewmodel/artist/artist_cubit.dart';

import 'package:music_dezeer/viewmodel/home/cubit/home_cubit.dart';
import 'package:music_dezeer/widgets/custom_text.dart';

class ArtistDetails extends StatelessWidget {
  final ArtistModel artistModel;

  const ArtistDetails({required this.artistModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                CachedNetworkImageProvider(artistModel.picture),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            msg: artistModel.name,
                            size: 25,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      BlocConsumer<ArtistCubit, ArtistState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          var cubit = ArtistCubit.get(context);
                          return state is GetATracksLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Center(
                                  child: Container(
                                    child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: cubit.tracks.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 10,
                                              childAspectRatio: 2.5 / 3,
                                              mainAxisSpacing: 10),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          artistModel.picture,
                                                      fit: BoxFit.cover,
                                                      height: 120,
                                                      width: 120,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: BlocConsumer<
                                                        HomeCubit, HomeState>(
                                                      listener:
                                                          (context, state) {},
                                                      builder:
                                                          (context, state) {
                                                        var homeCubit =
                                                            HomeCubit.get(
                                                                context);
                                                        return GestureDetector(
                                                          onTap: () {
                                                            homeCubit.togglrPlayer(
                                                                url: cubit
                                                                    .tracks[
                                                                        index]
                                                                    .preview,
                                                                track: cubit
                                                                        .tracks[
                                                                    index]);
                                                          },
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.pink,
                                                            child: Icon(
                                                              cubit
                                                                  .tracks[index]
                                                                  .icon,
                                                              color:
                                                                  Colors.white,
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
                                                msg: cubit.tracks[index].title,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
