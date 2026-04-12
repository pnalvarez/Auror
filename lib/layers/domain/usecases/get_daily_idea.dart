import 'package:auror/layers/domain/models/idea_domain.dart';
import 'package:injectable/injectable.dart';

abstract class IGetDailyIdea {
  Future<IdeaDomain> call();
}

@Injectable(as: IGetDailyIdea)
class GetDailyIdea implements IGetDailyIdea {
  @override
  Future<IdeaDomain> call() async {
    // Simulate fetching daily idea with a delay.
    await Future.delayed(const Duration(seconds: 1));
    return const IdeaDomain(cards: [], totalTime: 7);
  }
}
