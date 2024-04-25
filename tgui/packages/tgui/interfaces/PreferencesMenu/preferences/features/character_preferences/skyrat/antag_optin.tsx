// THIS IS A SKYRAT UI FILE
import { FeatureChoiced, FeatureDropdownInput } from '../../base';

export const rr_opt_in_status_pref: FeatureChoiced = {
  name: 'Be Round Removed',
  description:
    'Enabling any non-ghost antags \
  (revenant, abductor contractor, etc.) will force your opt-in.',
  component: FeatureDropdownInput,
};
