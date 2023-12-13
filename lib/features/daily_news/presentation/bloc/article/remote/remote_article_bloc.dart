import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticlesUseCase;

  RemoteArticlesBloc(this._getArticlesUseCase): super(const RemoteArticlesLoading()) {
    on <GetArticles> (onGetArticles);
  }

  void onGetArticles(GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticlesUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print("data=> ${dataState.data}");

      emit(
        RemoteArticlesDone(dataState.data!)
      );
    }

    if(dataState is DataFailed) {
      print("errror=> ${dataState.error}");
      emit(
        RemoteArticlesError(dataState.error!)
      );
    }
  }
}