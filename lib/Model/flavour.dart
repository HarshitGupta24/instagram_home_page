enum Flavours{
  dev,
  stage,
  prod,
}

Flavours flavour = Flavours.stage;


class ApiUrls{


  static String getBaseUrl(){
    if(flavour == Flavours.stage || flavour == Flavours.dev)
    {
      return "https://instagram130.p.rapidapi.com/";
    }else if(flavour == Flavours.prod)
    {
      return "-------prod_url--------";
    }
    return "https://instagram130.p.rapidapi.com/";
  }



  // endpoints
  static String postData = "account-medias?userid=13460080&first=10"; // get






}