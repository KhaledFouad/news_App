import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ketaby/core/utils/app_constants.dart';
import 'package:new_ketaby/core/widgets/custom_error_widget.dart';
import 'package:new_ketaby/core/widgets/loading_indicator_widget.dart';
import 'package:new_ketaby/feature/news/presentation/cubit/news_cubit.dart';
import 'package:new_ketaby/feature/news/presentation/cubit/news_state.dart';
import 'package:new_ketaby/feature/news/presentation/view/widgets/news_list_view_item_horizontal.dart';

class BooksViewBody extends StatelessWidget {
  const BooksViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsSuccessState ||
            state is GetSearchedNewsList ||
            state is ChangeIsSearchingState) {
          return ListView.separated(
            padding: EdgeInsets.all(AppConstants.defaultPadding),
            itemCount:
                NewsCubit.get(context).searchController.text.isEmpty
                    ? NewsCubit.get(context).products.length
                    : NewsCubit.get(context).searchedArticlesList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder:
                (context, index) => NewsListViewItemHorizontal(
                  index: index,
                  article:
                      NewsCubit.get(context).searchController.text.isEmpty
                          ? NewsCubit.get(context).products[index]
                          : NewsCubit.get(context).searchedArticlesList[index],
                ),
            separatorBuilder:
                (context, index) => SizedBox(height: AppConstants.padding10h),
          );
        } else if (state is NewsFailureState) {
          return CustomErrorWidget(error: state.error);
        } else {
          return LoadingIndicatorWidget();
        }
      },
    );
  }
}
