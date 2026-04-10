import 'package:auror/layers/domain/models/revision_domain.dart';
import 'package:injectable/injectable.dart';

abstract class IGetCardRevision {
  Future<RevisionDomain> call({required String cardId});
}

@Injectable(as: IGetCardRevision)
class GetCardRevision implements IGetCardRevision {
  @override
  Future<RevisionDomain> call({required String cardId}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return RevisionDomain(
      id: 'rev1',
      title: 'Inteligência emocional',
      question:
          'Como a inteligência emocional pode impactar a liderança eficaz?',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      category: 'Inteligência Emocional',
      minutes: 5,
      correctAnswer:
          'A inteligência emocional permite que os líderes compreendam e gerenciem suas próprias emoções, bem como as emoções de sua equipe, promovendo um ambiente de trabalho mais colaborativo e produtivo.',
      cardId: cardId,
    );
  }
}
