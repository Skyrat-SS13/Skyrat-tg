import { FeatureDropdownInput, Feature, FeatureNumberInput, CheckboxInput, FeatureTriColorInput, FeatureTriBoolInput, FeatureNumeric, FeatureToggle, FeatureChoiced } from "../../base";

export const penis_toggle: FeatureToggle = {
  name: "Penis",
  component: CheckboxInput,
};

export const feature_penis: Feature<string> = {
  name: "Penis Choice",
  component: FeatureDropdownInput,
};

export const penis_color: Feature<string[]> = {
  name: "Penis Color",
  component: FeatureTriColorInput,
};

export const penis_emissive: Feature<boolean[]> = {
  name: "Penis Emissives",
  component: FeatureTriBoolInput,
};

export const penis_sheath: Feature<string> = {
  name: "Penis Sheath",
  component: FeatureDropdownInput,
};

export const penis_length: FeatureNumeric = {
  name: "Penis Length",
  component: FeatureNumberInput,
};

export const penis_girth: FeatureNumeric = {
  name: "Penis Girth",
  component: FeatureNumberInput,
};

export const penis_taur_mode_toggle: FeatureToggle = {
  name: "Penis Taur Mode",
  component: CheckboxInput,
};

export const testicles_toggle: FeatureToggle = {
  name: "Testicles",
  component: CheckboxInput,
};

export const feature_testicles: Feature<string> = {
  name: "Testicles Choice",
  component: FeatureDropdownInput,
};

export const testicles_color: Feature<string[]> = {
  name: "Testicles Color",
  component: FeatureTriColorInput,
};

export const testicles_emissive: Feature<boolean[]> = {
  name: "Testicles Emissives",
  component: FeatureTriBoolInput,
};

export const balls_size: FeatureNumeric = {
  name: "Testicles Size",
  component: FeatureNumberInput,
};

export const vagina_toggle: FeatureToggle = {
  name: "Vagina",
  component: CheckboxInput,
};

export const feature_vagina: Feature<string> = {
  name: "Vagina Choice",
  component: FeatureDropdownInput,
};

export const vagina_color: Feature<string[]> = {
  name: "Vagina Color",
  component: FeatureTriColorInput,
};

export const vagina_emissive: Feature<boolean[]> = {
  name: "Vagina Emissives",
  component: FeatureTriBoolInput,
};

export const womb_toggle: FeatureToggle = {
  name: "Womb",
  component: CheckboxInput,
};

export const feature_womb: Feature<string> = {
  name: "Womb Choice",
  component: FeatureDropdownInput,
};

export const breasts_toggle: FeatureToggle = {
  name: "Breasts",
  component: CheckboxInput,
};

export const feature_breasts: Feature<string> = {
  name: "Breasts Choice",
  component: FeatureDropdownInput,
};

export const breasts_color: Feature<string[]> = {
  name: "Breasts Color",
  component: FeatureTriColorInput,
};

export const breasts_emissive: Feature<boolean[]> = {
  name: "Breasts Emissives",
  component: FeatureTriBoolInput,
};

export const breasts_lactation_toggle: FeatureToggle = {
  name: "Breasts Lactation",
  component: CheckboxInput,
};

export const breasts_size: FeatureNumeric = {
  name: "Breasts Size",
  component: FeatureNumberInput,
};

export const anus_toggle: FeatureToggle = {
  name: "Anus",
  component: CheckboxInput,
};

export const feature_anus: Feature<string> = {
  name: "Anus Choice",
  component: FeatureDropdownInput,
};

export const body_size: FeatureNumeric = {
  name: "Body Size",
  component: FeatureNumberInput,
};

export const erp_status_pref: FeatureChoiced = {
  name: "ERP Status",
  component: FeatureDropdownInput,
};

export const erp_status_pref_nc: FeatureChoiced = {
  name: "ERP Non-Con Status",
  component: FeatureDropdownInput,
};

export const erp_status_pref_v: FeatureChoiced = {
  name: "ERP Vore Status",
  component: FeatureDropdownInput,
};

export const erp_status_pref_mechanics: FeatureChoiced = {
  name: "ERP Mechanical Status",
  component: FeatureDropdownInput,
};

