import 'package:flutter/material.dart';
import 'package:news/core/services/url_service/url_service.dart';

import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/news_response.dart';
import '../manager/layout_provider.dart';




class ArticlesScreen extends StatelessWidget {
   ArticlesScreen({super.key,});


  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return Column(
          children: [
            DefaultTabController(
              length: provider.sources.length,
              child: TabBar(
                onTap: (index){
                  provider.onChangeSource(provider.sources[index]);
                },
                indicatorColor: AppColors.white,
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.white,
                isScrollable: true,
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                tabs: provider.sources.map((source) {
                  return Tab(
                    text: source.name ?? '',
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 12,),
            Expanded(child: ListView.separated(
                itemBuilder: (context,index){
                  final Articles article = provider.articles[index];
                  return InkWell(
                    onTap: (){
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context){
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: SafeArea(
                                child: Container(
                                  height: MediaQuery.of(context).size.height/2,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(16),
                                          border: BoxBorder.all(
                                              color: AppColors.white
                                          )
                                      ),
                                      child: Column(
                                        children: [
                                          Image.network(article.urlToImage??"",fit: BoxFit.cover,width: double.infinity,),
                                          SizedBox(height: 10,),
                                          Text(article.content??"",style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.black
                                          ),),
                                          SizedBox(height: 10,),
                                          ElevatedButton(onPressed: (){
                                            UrlService.openArticle(context, article.url);
                                          }, style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8)
                                            )
                                          ),child: Center(child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Text("View Full Article",style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                            ),),
                                          )),
                                          ),
                                        ],
                                      ),
                                    ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: BoxBorder.all(
                              color: AppColors.white
                          )
                      ),
                      child: Column(
                        children: [
                          Image.network(article.urlToImage??"",fit: BoxFit.cover,width: double.infinity,),
                          SizedBox(height: 10,),
                          Text(article.title??"",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white
                          ),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text("By : ${article.author}"??"",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xffA0A0A0),
                                ),),
                              ),
                              Text(article.publishedAt?.substring(0,10)??"",style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color(0xffA0A0A0),
                              ),),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }, separatorBuilder: (context,index){
              return SizedBox(height: 12,);
            }, itemCount: provider.articles.length))
          ],
        );

      },

    );
  }
}
