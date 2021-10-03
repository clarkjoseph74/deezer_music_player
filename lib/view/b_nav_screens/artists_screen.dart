import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dezeer/constants.dart';
import 'package:music_dezeer/view/secondery_view/artist_details.dart';
import 'package:music_dezeer/viewmodel/artist/artist_cubit.dart';
import 'package:music_dezeer/widgets/common_functions.dart';

import 'package:music_dezeer/widgets/custom_text.dart';

class ArtistsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArtistCubit, ArtistState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ArtistCubit.get(context);
        return state is GetArtistsLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                  child: state is GetArtistsLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 2.5 / 3),
                          itemCount: cubit.artists.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: GestureDetector(
                                onTap: () {
                                  navigateTo(
                                      context: context,
                                      widget: ArtistDetails(
                                          artistModel: cubit.artists[index]));
                                  cubit.getArtistTracks(
                                      baseUrl: cubit.artists[index].tracks);
                                },
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 135,
                                        width: 135,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  cubit.artists[index].picture),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 3),
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: CustomText(
                                          msg: cubit.artists[index].name,
                                          color: Colors.white,
                                        ),
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
