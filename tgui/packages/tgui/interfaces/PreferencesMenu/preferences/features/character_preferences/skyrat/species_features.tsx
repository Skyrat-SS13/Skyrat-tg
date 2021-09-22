import { FeatureChoiced, FeatureDropdownInput, Feature, FeatureColorInput } from "../../base";

export const feature_leg_type: FeatureChoiced = {
  name: "Leg type",
  component: FeatureDropdownInput,
};

export const feature_mcolor2: Feature<string> = {
  name: "Mutant color 2",
  component: FeatureColorInput,
};
export const feature_mcolor3: Feature<string> = {
  name: "Mutant color 3",
  component: FeatureColorInput,
};

