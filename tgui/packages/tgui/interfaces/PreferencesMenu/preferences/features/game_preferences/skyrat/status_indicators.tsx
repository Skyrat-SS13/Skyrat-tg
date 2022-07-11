import { CheckboxInput, FeatureToggle } from '../../base';

export const enable_status_indicators: FeatureToggle = {
  name: 'Display Status Indicators',
  category: 'GAMEPLAY',
  description: 'This toggles whether or not you will see status indicators.',
  component: CheckboxInput,
};
