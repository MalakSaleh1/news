import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/modules/layout/view/manager/layout_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/url_service/url_service.dart';
import '../../data/models/news_response.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>LayoutProvider(),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<LayoutProvider>(
              builder: (BuildContext context, LayoutProvider provider, Widget? child) {
                return Column(
                  children: [
                    TextFormField(
                      style: TextStyle(color:AppColors.white),
                      controller: provider.controller,
                      cursorColor: AppColors.white,
                      onFieldSubmitted: (value) => context.read<LayoutProvider>().onSearch(value),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.white,
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.white,
                            )
                        ),

                        hintText: "Search",
                        hintStyle:TextStyle(
                          color: AppColors.white,

                        ) ,
                        prefixIcon: Icon(Icons.search,color: AppColors.white,),
                        suffixIcon: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.close,color: AppColors.white,)),
                      ),
                    ),
                    SizedBox(height: 12,),
                    Expanded(child: ListView.separated(
                        itemBuilder: (context,index){
                          final Articles article = provider.searchResult[index];
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
                                        child: Text("By : ${article.author}"??"",
                                        maxLines: 1,
                                          overflow: TextOverflow.ellipsis
                                          ,style: TextStyle(
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
                    }, itemCount: provider.searchResult.length))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
