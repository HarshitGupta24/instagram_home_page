// States


import '../Model/Feed.dart';

abstract class DataState {}

class InitialDataState extends DataState {}

class LoadingDataState extends DataState {}

class LoadedDataState extends DataState {
  List<Feed> fetchedData;
  LoadedDataState( {required List<Feed> this.fetchedData});
}
class ErrorDataState extends DataState {
  final String error;

  ErrorDataState(this.error);
}