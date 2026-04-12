// Home tab — greetings, section headers, daily idea card

String homeGreeting(String userName) => 'Olá, $userName';

const homeHeaderTodayYouHave = 'Hoje você tem ';
const homeHeaderRevisionConnector = ' de revisão + ';
const homeHeaderDailyIdeaSuffix = ' para aprender a ideia do dia.';

String homeHeaderMinutes(int minutes) => '$minutes min';

const homeSectionPendingRevisions = 'Revisões pendentes';
const homeSectionNewIdeas = 'Novas ideias';

const homeDailyIdeaTitle = 'Descubra algo novo';

String homeDailyIdeaDescription(int cards) =>
    '$cards ideias selecionadas para você';

const homeDailyIdeaCta = 'Aprender agora';
const seeMore = 'Ver mais';
