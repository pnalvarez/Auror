import 'package:injectable/injectable.dart';

abstract class ISendAnswer {
  Future<void> call({required String answer, required String revisionId});
}

@Injectable(as: ISendAnswer)
class SendAnswer implements ISendAnswer {
  @override
  Future<void> call({
    required String answer,
    required String revisionId,
  }) async {
    // TODO: POST to API / persist locally.
  }
}
