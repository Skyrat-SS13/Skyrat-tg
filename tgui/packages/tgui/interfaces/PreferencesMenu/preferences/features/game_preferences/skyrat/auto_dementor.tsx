import { FeatureToggle, CheckboxInput } from '../../base';

export const auto_dementor_pref: FeatureToggle = {
  name: 'Auto dementor',
  category: 'ADMIN',
  description: 'When enabled, you will automatically dementor.',
  component: CheckboxInput,
};
