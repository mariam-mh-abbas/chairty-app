// lib/helpers/cart_item_helper.dart

import 'package:charity_project/blocForApp/Box/bloc/box_bloc.dart';
import 'package:charity_project/blocForApp/blocAllCampaign/bloc/all_campaign_bloc.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CartItemHelper {
  static String? getLocalizedItemName(
    BuildContext context,
    CartItemModel item,
  ) {
    final isArabic = context.locale.languageCode == 'ar';

    // احضر القوائم من البلوكات
    final boxes = context.read<BoxBloc>().boxservice.responce.data["data"];
    final campaigns = context.read<AllCampaignBloc>().allcampaignsservice.responce.data["data"];

    if (item.boxId != null) {
      final box = boxes.firstWhere((b) => b.id == item.boxId, orElse: () => null);
      return isArabic ? box?.nameAr : box?.nameEn;
    } else if (item.Campainid != null) {
      final campaign = campaigns.firstWhere((c) => c.id == item.Campainid, orElse: () => null);
      return isArabic ? campaign?.nameAr : campaign?.nameEn;
    }

    return null;
  }
}
