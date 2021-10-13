import { FeatureChoiced, FeatureDropdownInput, Feature, FeatureColorInput } from "../../base";


export const hair_gradient_color: Feature<string> = {
  name: "Hair Gradient Color",
  component: FeatureColorInput,
};

export const hair_gradient: FeatureChoiced = {
  name: "Hair Gradient",
  component: FeatureDropdownInput,
};
