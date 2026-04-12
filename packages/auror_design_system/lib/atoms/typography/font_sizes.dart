/// Type scale for [auror] (aligned with [ambush_people] numeric steps for body/label/tag).
library;

const double labelXS = 12;
const double labelS = 14;
const double labelM = 16;
const double labelL = 18;

const double defaultTiny = 10;
const double defaultSBody = 12;
const double defaultBody = 14;
const double defaultXS2 = 18;
const double defaultXS = 20;
const double defaultS = 24;
const double defaultM = 28;
const double defaultL = 32;
const double defaultXL = 40;
const double defaultXL2 = 48;

/// Semantic headline / subtitle steps (XL → 2XS), mapped to the scale above.
const double headlineXl = defaultXL2;
const double headlineL = defaultXL;
const double headlineM = defaultL;
const double headlineS = defaultM;
const double headlineXs = defaultS;
const double headline2xs = defaultXS;

const double subtitleXl = headlineXl;
const double subtitleL = headlineL;
const double subtitleM = headlineM;
const double subtitleS = headlineS;
const double subtitleXs = headlineXs;
const double subtitle2xs = headline2xs;
