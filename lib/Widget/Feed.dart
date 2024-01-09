
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../Model/Feed.dart';
import '../controller/post_bloc.dart';
import '../controller/post_even.dart';
import '../controller/post_state.dart';
import '../data/FeedData.dart';
import '../utils/like_animation.dart';

void main() {
  runApp(FeedWidget());
}

class FeedWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyFeed(title: '',);
  }
}

class MyFeed extends StatefulWidget {
  MyFeed ({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyFeedState createState() => _MyFeedState();
}

class _MyFeedState extends State<MyFeed> {



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DataBloc()..add(FetchDataEvent()),
        child:  BlocBuilder<DataBloc, DataState>(
        builder: (context, state)
    {
      // Handle different states and update UI accordingly
      if (state is LoadedDataState) {
        // Use data from state to update UI
        return Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: ListView.builder(
              itemCount: posts.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image(
                                    image: NetworkImage(
                                        state.fetchedData[index].useravatar/*posts[index].useravatar*/),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.fetchedData[index].username/*posts[index].username*/),
                                    Text(state.fetchedData[index].profileCaption,
                                      style: TextStyle(color: Colors.grey[700],
                                          fontSize: 12),),
                                  ],
                                )
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.more_vert, color: Colors.grey[800],),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            state.fetchedData[index].isLikedAnimation =
                            !state.fetchedData[index].isLiked;
                          });
                          print(
                              "isAnimating ${ state.fetchedData[index].isLikedAnimation}");
                          /*if(posts[index].isLiked==false){
                            setState(() {
                              posts[index].isLiked=true;
                            });
                          }*/

                          // Schedule a callback after 2 seconds
                          Future.delayed(const Duration(milliseconds: 400), () {
                            setState(() {
                              state.fetchedData[index].isLikedAnimation = false;
                              state.fetchedData[index].isLiked = !state.fetchedData[index].isLiked;
                            });
                          });
                        },


                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            FadeInImage(
                              image: NetworkImage(state.fetchedData[index].feedImage),
                              placeholder: AssetImage("assets/placeholder.jpg"),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: state.fetchedData[index].isLikedAnimation ? 1 : 0,
                              child: LikeAnimation(
                                isAnimating: state.fetchedData[index].isLiked,
                                duration: const Duration(
                                  milliseconds: 200,
                                ),
                                onEnd: () {
                                  /*setState(() {
                                posts[index].isLikedAnimation = posts[index].isLiked;
                              });*/
                                  print("fir milange");
                                },
                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 100,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    state.fetchedData[index].isLiked =
                                    !state.fetchedData[index].isLiked;
                                  });
                                  print(state.fetchedData[index].isLiked);
                                },
                                icon: state.fetchedData[index].isLiked ? const Icon(
                                  Icons.favorite, color: Colors.red,)
                                    : Icon(
                                  FeatherIcons.heart, color: Colors.grey[800],
                                  size: 25,),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(FeatherIcons.messageCircle,
                                  color: Colors.grey[800], size: 25,),
                              ),
                              IconButton(
                                onPressed: () {
                                  Share.share(state.fetchedData[index].feedImage);
                                },
                                icon: Icon(
                                  FeatherIcons.send, color: Colors.grey[800],
                                  size: 25,),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                state.fetchedData[index].isSaved = !state.fetchedData[index].isSaved;
                              });
                            },
                            icon: state.fetchedData[index].isSaved ? Icon(Icons.bookmark,
                              color: Colors.grey[800], size: 25,) : Icon(
                              FeatherIcons.bookmark, color: Colors.grey[800],
                              size: 25,),
                          ),
                        ],
                      ),
                      _FeedStats(post: state.fetchedData[index],),
                      _FeedCaption(index: index,),
                    ],
                  ),
                );
              }),
        );
      }
      else if (state is ErrorDataState) {
        // Handle error state
        return const Text('Error: Something went wrong');
      }
      else {
        // Handle other states if needed
        return Center(child: CircularProgressIndicator(),);
      }
    }
    ),);

  }
}

class _FeedStats extends StatelessWidget{

  final Feed post;

  const _FeedStats({
    Key? key,
    required this.post,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: RichText(
        softWrap: true,
        overflow: TextOverflow.visible,
        text: TextSpan(
          children: [
            TextSpan(
              text: post.friendList==null?post.likes+" likes":"Liked by "+post.friendList+" and "+ post.likes+" others",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedCaption extends StatelessWidget{

  final int index;

   _FeedCaption({
    Key? key,
    required this.index,
  }) : super(key: key);

  //bool isLiked= false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 5,
          ),
          child: RichText(
            softWrap: true,
            overflow: TextOverflow.visible,
            text: TextSpan(
              children: [
                TextSpan(
                  text: posts[index].username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                TextSpan(
                  text: " ${posts[index].caption}",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 14,
          ),
          alignment: Alignment.topLeft,
          child: const Text(
            "january 2024",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}


/*class FeedButton extends StatelessWidget{
  bool isLiked =false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                setState((){
                  isLiked=!isLiked;
                });
                print(isLiked);

              },
              icon: isLiked?  const Icon(Icons.favorite,color: Colors.red,)
               :Icon(FeatherIcons.heart, color: Colors.grey[800], size: 25,),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(FeatherIcons.messageCircle, color: Colors.grey[800], size: 25,),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(FeatherIcons.send, color: Colors.grey[800], size: 25,),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(FeatherIcons.bookmark, color: Colors.grey[800], size: 25,),
        ),
      ],
    );
  }
}*/

