import 'package:cleanarchitecture/features/daily_news/domain/entities/article.dart';
import 'package:cleanarchitecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:cleanarchitecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:cleanarchitecture/features/daily_news/presentation/widgets/article_widgets.dart';
import 'package:cleanarchitecture/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text('Daily News', style: TextStyle(color: Colors.black)),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
        builder: (_, state) {
          if (state is RemoteArticleLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is RemoteArticleError) {
            return const Center(child: Icon(Icons.refresh));
          }
          if (state is RemoteArticleDone) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return  ArticleWidget(
                    article: state.articles![index],
                    onArticlePressed: (article) => _onArticlePressed(context,article),
                  );
              },
              itemCount: state.articles!.length,
              );
          }
          return const SizedBox(); 
        });
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}
