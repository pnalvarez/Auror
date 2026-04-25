import 'package:injectable/injectable.dart';

abstract class ISelectSubscription {
  Future<void> call({required String id});
}

@Injectable(as: ISelectSubscription)
class SelectSubscription implements ISelectSubscription {
  @override
  Future<void> call({required String id}) async {}
}
