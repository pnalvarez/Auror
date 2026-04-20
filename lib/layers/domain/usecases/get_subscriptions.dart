import 'package:auror/layers/domain/models/subscription_domain.dart';
import 'package:injectable/injectable.dart';

abstract class IGetSubscriptions {
  Future<List<SubscriptionDomain>> call();
}

@Injectable(as: IGetSubscriptions)
class GetSubscriptions implements IGetSubscriptions {
  @override
  Future<List<SubscriptionDomain>> call() async {
    return [
      SubscriptionDomain(
        id: 'standard',
        subscriptionName: 'Auror Grátis',
        description: 'Recursos essenciais para o dia a dia.',
        isPaid: false,
        benefits: [
          'Cartões de recordação diários',
          'Rastreamento básico de ideias',
          'Temas da comunidade',
        ],
        isCurrent: true,
      ),
      SubscriptionDomain(
        id: 'pro',
        subscriptionName: 'Auror Pro',
        description:
            'Biblioteca completa, sincronização e suporte prioritário.',
        isPaid: true,
        benefits: [
          'Baralhos de recordação ilimitados',
          'Sincronização na nuvem entre dispositivos',
          'Análises avançadas',
          'Suporte prioritário',
        ],
        isCurrent: false,
        price: r'R$ 4,99',
        period: 'mês',
      ),
    ];
  }
}
