import 'package:injectable/injectable.dart';

abstract class ISaveRecallCard {
  Future<void> call({required String cardId});
}

@Injectable(as: ISaveRecallCard)
class SaveRecallCard implements ISaveRecallCard {
  @override
  Future<void> call({required String cardId}) async {}
}
