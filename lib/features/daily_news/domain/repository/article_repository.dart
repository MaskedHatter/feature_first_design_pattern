import 'package:cleanarchitecture/core/resources/data_state.dart';
import 'package:cleanarchitecture/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  Future<List<ArticleEntity>> getSavedArticles();

  Future<void> removeArticle(ArticleEntity article);

  Future<void> saveArticle(ArticleEntity article);
}