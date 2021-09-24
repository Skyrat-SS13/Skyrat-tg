import { FeatureChoiced, FeatureDropdownInput, Feature, FeatureColorInput, FeatureTextInput, FeatureShortTextInput } from "../../base";

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

export const flavor_text: Feature<string> = {
  name: "Flavor Text",
  description: "Describe your character!",
  component: FeatureTextInput,
};

export const ooc_notes: Feature<string> = {
  name: "OOC Notes",
  description: "Talk about your character OOCly!",
  component: FeatureTextInput,
};

export const custom_species: Feature<string> = {
  name: "Custom Species Name",
  description: "Want to have a fancy species name? Put it here, or leave it blank.",
  component: FeatureShortTextInput,
};

export const custom_species_lore: Feature<string> = {
  name: "Custom Species Lore",
  description: "Add some lore for your species! Won't show up if there's no custom species.",
  component: FeatureTextInput,
};
