// THIS IS A SKYRAT UI FILE
import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';

const LoneInfiltrator: Antagonist = {
  key: 'loneinfiltrator',
  name: 'Lone Infiltrator',
  description: [
    multiline`A midround traitor that can spawn near the station, equipped with
    a Syndicate Modsuit and equipment befitting a station boarder.
    Float onto the station and complete your objectives.`,
  ],
  category: Category.Midround,
};

export default LoneInfiltrator;
