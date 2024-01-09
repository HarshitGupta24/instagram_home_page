import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_home_page/controller/post_even.dart';
import 'package:instagram_home_page/controller/post_state.dart';
import 'package:http/http.dart' as http;
import '../Model/Feed.dart';
import '../Model/flavour.dart';



// BLoC
class DataBloc extends Bloc<DataEvent, DataState> {
  List<Feed> postitems = [];

  DataBloc() : super(InitialDataState());
  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    final List<Feed> _tempList = [] ;
    if (event is FetchDataEvent) {
      yield LoadingDataState();

      try {
        final response = await http.get(
          Uri.parse(ApiUrls.getBaseUrl()+ApiUrls.postData),
          /*params: {
            "userid": '13460080',
            "first": '10'
          },*/
          headers: {
            //'Content-type': 'application/json; charset=UTF-8',
              'X-RapidAPI-Key': '125389e1dbmsha1314d4a72a3c32p1fe904jsnd60d1b34836d',
              'X-RapidAPI-Host': 'instagram130.p.rapidapi.com'

            // Add any other headers as needed by the API
          },
        );
        print('Response status: ${response.statusCode}');


        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print(data.toString());

          for(int i =0; i<data["edges"].length; i++)
          {
            _tempList.add(Feed.fromJSON(data["edges"][i])) ;
            print("---------------list----------$i");
          }

          yield LoadedDataState( fetchedData: _tempList);
        } else {
          yield ErrorDataState('Request failed with status: ${response.statusCode}');
        }
      } catch (e) {
        yield ErrorDataState('Error: $e');
      }

    }

  }
}