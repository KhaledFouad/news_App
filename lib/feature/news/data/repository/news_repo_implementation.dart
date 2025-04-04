import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:new_ketaby/core/api/api_services.dart';
import 'package:new_ketaby/core/api/end_points.dart';
import 'package:new_ketaby/core/errors/failures.dart';
import 'package:new_ketaby/feature/news/data/model/news/article.dart';
import 'package:new_ketaby/feature/news/data/repository/news_repo.dart';

class NewRepoImplementation extends NewRepository {
  final ApiServices apiServices;

  NewRepoImplementation(this.apiServices);

  @override
  Future<Either<Failure, List<Article>>> getNews() async {
    try {
      final response = await apiServices.get(endPoint: EndPoints.products);
      return right(
        (response.data['articles'] as List)
            .map((e) => Article.fromJson(e))
            .toList(),
      );
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure(error.response!.data['message'].toString()));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
