// THIS IS A SKYRAT UI FILE
import {
  Feature,
  FeatureChoiced,
  FeatureDropdownInput,
  FeatureShortTextInput,
} from '../../base';

export const pet_owner: FeatureChoiced = {
  name: 'Pet Owner',
  component: FeatureDropdownInput,
};

export const pet_name: Feature<string> = {
  name: 'Pet Name',
  description:
    "If blank, will use the mob's default name. Ex. Axolotls will be called axolotl.",
  component: FeatureShortTextInput,
};

export const pet_desc: Feature<string> = {
  name: 'Pet Description',
  description: "If blank, will use the mob's default description.",
  component: FeatureShortTextInput,
};
