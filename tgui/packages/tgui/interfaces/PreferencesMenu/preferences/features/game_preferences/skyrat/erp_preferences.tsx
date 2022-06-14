import { CheckboxInput, FeatureDropdownInput, FeatureChoiced, FeatureToggle } from "../../base";

export const master_erp_pref: FeatureToggle = {
  name: "Show/Hide Erotic Roleplay Preferences",
  category: "ERP",
  description: "This shows/hides ERP preferences.",
  component: CheckboxInput,
};

export const erp_pref: FeatureToggle = {
  name: "Erotic Roleplay Interaction",
  category: "ERP",
  description: "This informs players of if you wish to engage in ERP.",
  component: CheckboxInput,
};

export const cum_face_pref: FeatureToggle = {
  name: "Cum face",
  category: "ERP",
  description: "Toggles if you are able to recieve the 'cumface' trait.",
  component: CheckboxInput,
};

export const bimbofication_pref: FeatureToggle = {
  name: "Bimbofication",
  category: "ERP",
  description: "Toggles if you are able to react to the effects of bimbofication.",
  component: CheckboxInput,
};

export const aphro_pref: FeatureToggle = {
  name: "Aphrodisiacs",
  category: "ERP",
  description: "Toggles whether you wish to recieve the effects of aphrodisiacs",
  component: CheckboxInput,
};

export const sextoy_pref: FeatureToggle = {
  name: "Sex toy interaction",
  category: "ERP",
  description: "When enabled, you will be able to interact with sex toys.",
  component: CheckboxInput,
};

export const breast_enlargement_pref: FeatureToggle = {
  name: "Breast enlargement",
  category: "ERP",
  description: "Determines if you wish to recieve the effects of breast enlargement chemicals.",
  component: CheckboxInput,
};

export const penis_enlargement_pref: FeatureToggle = {
  name: "Penis enlargement",
  category: "ERP",
  description: "Determines if you wish to recieve the effects of penis enlargement chemicals.",
  component: CheckboxInput,
};

export const gender_change_pref: FeatureToggle = {
  name: "Forced gender change",
  category: "ERP",
  description: "Determines if you wish to allow forced gender changing.",
  component: CheckboxInput,
};

export const autocum_pref: FeatureToggle = {
  name: "Autocum",
  category: "ERP",
  description: "Toggles whether you automatically cum using the arousal system, or if you need to do it manually.",
  component: CheckboxInput,
};

export const erp_sexuality_pref: FeatureChoiced = {
  name: "Sexuality Preference",
  category: "ERP",
  description: "Determines what sexual content you see, limited use. None will show all content.",
  component: FeatureDropdownInput,
};
