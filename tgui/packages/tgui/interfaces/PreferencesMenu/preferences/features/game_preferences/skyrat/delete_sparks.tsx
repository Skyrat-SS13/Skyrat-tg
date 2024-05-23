// THIS IS A SKYRAT UI FILE
import { CheckboxInput, FeatureToggle } from '../../base';

export const delete_sparks_pref: FeatureToggle = {
  name: 'Deletion sparks',
  category: 'ADMIN',
  description:
    'Toggles if you want to play a sparking animation when deleting things as an admin.',
  component: CheckboxInput,
};
