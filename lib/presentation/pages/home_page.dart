import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:news_app/core/constants/themes/light/colors.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:unicons/unicons.dart';

import '../blocs/news/news_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  int categorySelectedIndex = 0;
  bool latestNewsShow = true;
  bool businessNewsShow = false;
  int currentPage = 1;

  List<String> categories = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology'];
  List<ArticleModel> articleList = [];

  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(LoadNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.secondaryColor,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: ColorApp.secondaryColor,
            pinned: true,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'FlashBytes',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: Colors.black),
              ),
            ),
            leading: Icon(
              UniconsLine.apps,
              color: Colors.black,
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  UniconsLine.search,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SliverFixedExtentList(
            itemExtent: 60,
            delegate: SliverChildListDelegate(
              [
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<NewsBloc>(context).add(
                          LoadNewsEvent(category: categories[index]),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        margin: const EdgeInsets.only(left: 16, right: 0, bottom: 10, top: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: BlocProvider.of<NewsBloc>(context, listen: true).selectedCategory == categories[index]
                              ? Colors.green
                              : ColorApp.mainColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          categories[index],
                          style: const TextStyle(
                            color: ColorApp.secondaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is LoadingNewsState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is LoadedNewsState) {
                  articleList = state.articleModel;
                }

                if (state is ErrorNewsState) {
                  return const Center(
                    child: Text('Error home'),
                  );
                }

                return LazyLoadScrollView(
                  isLoading: state is LoadingPaginationNewsState,
                  onEndOfPage: () => BlocProvider.of<NewsBloc>(context).add(LoadPaginationNewsEvent()),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: articleList.length,
                          itemBuilder: (context, index) {
                            ArticleModel snapshot = articleList[index];
                            return Container(
                              height: 520,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${snapshot.urlToImage}',
                                  ),
                                  fit: BoxFit.cover,
                                  opacity: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16,
                                bottom: 0,
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(16),
                                          bottomLeft: Radius.circular(16),
                                        ),
                                        color: ColorApp.mainColor,
                                      ),
                                      child: Text(
                                        '${snapshot.title}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: ColorApp.secondaryColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Icon(
                                        UniconsLine.bookmark,
                                        color: ColorApp.mainColor,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 16,
                                    left: 16,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: ColorApp.secondaryColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        '${snapshot.source!.name}',
                                        style: const TextStyle(
                                          color: ColorApp.mainColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: state is LoadingPaginationNewsState,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: selectedIndex),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 40,
            spreadRadius: 1,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: GNav(
        selectedIndex: selectedIndex,
        haptic: true,
        activeColor: ColorApp.secondaryColor,
        color: ColorApp.mainColor,
        rippleColor: ColorApp.transparentColor,
        hoverColor: ColorApp.transparentColor,
        tabBackgroundColor: ColorApp.mainColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        gap: 8,
        tabs: const [
          GButton(
            icon: UniconsLine.home,
            text: 'Home',
          ),
          GButton(
            icon: UniconsLine.heart,
            text: 'Likes',
          ),
          GButton(
            icon: UniconsLine.search,
            text: 'Search',
          ),
          GButton(
            icon: UniconsLine.user,
            text: 'Profile',
          )
        ],
      ),
    );
  }
}
