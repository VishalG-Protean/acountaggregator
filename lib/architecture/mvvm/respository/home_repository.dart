
import 'package:proteanmobileapp/architecture/mvvm/data/network/BaseApiServices.dart';
import 'package:proteanmobileapp/architecture/mvvm/data/network/NetworkApiService.dart';
import 'package:proteanmobileapp/architecture/mvvm/model/movies_model.dart';
import 'package:proteanmobileapp/architecture/mvvm/res/app_url.dart';

class HomeRepository {

  BaseApiServices _apiServices = NetworkApiService() ;

  Future<MovieListModel> fetchMoviesList()async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }

}