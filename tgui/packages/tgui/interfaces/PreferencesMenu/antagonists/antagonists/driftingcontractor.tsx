// THIS IS A SKYRAT UI FILE
import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';

export const CONTRACTOR_MECHANICAL_DESCRIPTION = multiline`
      Float onto the station and complete as many
      contracts for your employer as you can!
    `;

const DriftingContractor: Antagonist = {
  key: 'driftingcontractor',
  name: 'Drifting Contractor',
  description: [
    multiline`A Syndicate agent that can spawn near the station, equipped with
    top-of-the-line contractor gear, to complete contracts for the Syndicate.`,
    CONTRACTOR_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default DriftingContractor;
