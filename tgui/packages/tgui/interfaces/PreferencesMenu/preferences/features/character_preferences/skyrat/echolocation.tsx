// THIS IS A NOVA SECTOR UI FILE
import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureColorInput,
  FeatureDropdownInput,
  FeatureToggle,
} from '../../base';

export const echolocation_outline: Feature<string> = {
  name: 'Echo outline color',
  component: FeatureColorInput,
};

export const echolocation_key: FeatureChoiced = {
  name: 'Echolocation type',
  component: FeatureDropdownInput,
};

export const echolocation_use_echo: FeatureToggle = {
  name: 'Display echo overlay',
  component: CheckboxInput,
};
