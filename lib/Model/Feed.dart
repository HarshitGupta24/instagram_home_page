class Feed {
   String useravatar="";
   String username="";
   String feedImage="";
   bool isLiked=false;
   bool isLikedAnimation=false;
   bool isSaved=false;
   String caption="";
   String profileCaption="";
   String likes="";
   String friendList="";

  Feed({
     this.useravatar="",
     this.username="",
     this.feedImage="",
     this.caption="",
     this.isLiked=false,
     this.isSaved=false,
     this.profileCaption="",
     this.likes="",
     this.friendList="",
     this.isLikedAnimation=false,
  });

   Feed.fromJSON(dynamic json){
     try{
       useravatar=json["node"]["display_url"];
       username=json["node"]["owner"]["username"];
       feedImage=json["node"]["display_url"];
       caption=json["node"]["edge_media_to_caption"]["edges"][0]["node"]["text"];
       profileCaption="Sponsored";
       likes=json["node"]["edge_media_preview_like"]["count"].toString();
       friendList=json["node"]["owner"]["username"];
       print(useravatar.toString());

     }catch(e){
       print(e.toString());
     }
   }
}