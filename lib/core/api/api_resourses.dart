import 'package:charity_project/blocForApp/SponsorshipsByCategory/bloc/sponsorships_by_category_bloc_bloc.dart';
import 'package:charity_project/blocForApp/blocCampaignByCategory/bloc/campaign_by_category_id_bloc.dart';

class ApiResourses {
  static const String campaignsDetails = "campaigns/Campaign/show";
  static  String humancaseDetails (int id) {
    return "humanCases/HumanCase/get/${id}/for/user";
   
  }
   static const String allhumancases = "humanCases/HumanCase/getAll/for/user";
   static String humanCaseByCategory(int id){
    return "humanCases/HumanCase/category/$id/for/user";
   }
   static const String allSponsorships = "sponsorships/Sponsorship";
   static String SponsorshipsByCategory(int id){
    return "sponsorships/Sponsorship/category/$id";
   }

    static String SponsorshipDetails(int id){
    return "sponsorships/Sponsorship/show/$id";
   }


   static String Box(String Type){
    return "box/getOne/$Type";
   }
    static const String GiftDonaition = "gift/donateAsGift";
    static const String OncePayment = "transaction/donateOnceTime";
    static const String InKindDonaition = "inKinds/add/for/user";
    static String PlanSponsorship(int id){
return "plans/create/forSponsorship/$id";
    }
    static const String PeriodicallyDonaition = "plans/active/recurring";
    static const String AllCampaigns = "campaigns/Campaign";
     static const String HomeCampaigns = "campaigns/Campaign/byDate";
     static const String EmergencyCases= "humanCases/HumanCase/getAll/emergency/for/user";
      static String CampaignByCategoryId(int id){
return "campaigns/Campaign/category/$id";
    }
     static String CategoryByMainCategory(String MainCategoryid){
return "category/$MainCategoryid";
    }
    static const String ArchivedCampaigns = "campaigns/Campaign/archived/forUser";
    static const String ArchivedHumanCases = "humanCases/HumanCase/archived/for/user";
}