import 'package:bloc/bloc.dart';
import 'package:charity_project/model/CategoryByMainCategoryModel.dart';
import 'package:charity_project/service/CategoryByMainCategoryService.dart';
import 'package:charity_project/service/HelpRequestService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'categorybymaincategory_event.dart';
part 'categorybymaincategory_state.dart';

class CategorybymaincategoryBloc extends Bloc<CategorybymaincategoryEvent, CategorybymaincategoryState> {
  Categorybymaincategoryservice categorybymaincategoryservice = Categorybymaincategoryservice();
  CategorybymaincategoryBloc() : super(CategorybymaincategoryInitial()) {
    on<FetchCategoryByMainCategory>((event, emit) async {
     
      try {
         emit(CategorybymaincategoryLoading());
       var result = await categorybymaincategoryservice.getCategoryByMainCategory(event.mainCategory);
        if (result!=null) {
          if (result is List) {
            final List<Categorybymaincategorymodel> categories =
                result.map((json) => Categorybymaincategorymodel.fromMap(json)).toList();

            print("Data fetched successfully");
            emit(CategorybymaincategoryLoaded(categories, event.mainCategory));
          } 
        } 
        
        
   else {
         emit(CategorybymaincategoryError("Failed to fetch Category By Main Category"));
      }
}  catch (e) {
  print("Campaign Fetch Error: $e"); 
  emit(CategorybymaincategoryError("حدث خطأ أثناء جلب الحملات: $e"));
}
      
    });
  }
}


