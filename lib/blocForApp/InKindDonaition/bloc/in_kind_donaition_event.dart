part of 'in_kind_donaition_bloc.dart';

@immutable
sealed class InKindDonaitionEvent {}
final class donateInKind extends InKindDonaitionEvent {
final InKindCategorymodel inkindItem;

  donateInKind(this.inkindItem);
}