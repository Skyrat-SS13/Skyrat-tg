// THIS IS A NOVA SECTOR UI FILE
import { FeatureChoiced, FeatureDropdownInput } from '../../base';

export const antag_opt_in_status_pref: FeatureChoiced = {
  name: 'Be Antagonist Target',
  description:
    'Enabling any non-ghost antags \
  (revenant, abductor contractor, etc.) will force your opt-in to be, \
  at minimum, "Temporarily Inconvenience".',
  component: FeatureDropdownInput,
};
