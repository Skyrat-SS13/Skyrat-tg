import { FeatureChoiced, createDropdownInput } from '../../base';

export const antag_opt_in_status_pref: FeatureChoiced = {
  name: 'Be Antagonist Target',
  component: createDropdownInput({
    3: 'Yes - Round Remove',
    2: 'Yes - Kill',
    1: 'Yes - Temporary/Inconvienence',
    0: 'No',
  }),
};
