import { FeatureDropdownInput, Feature, FeatureNumberInput, CheckboxInput, FeatureTriColorInput, FeatureTriBoolInput, FeatureNumeric, FeatureToggle, FeatureChoiced, FeatureValueProps, FeatureChoicedServerData } from '../../base';

export const feature_penis: Feature<string> = {
  name: 'Penis Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const penis_skin_tone: FeatureToggle = {
  name: 'Penis uses Skin Tone',
  component: CheckboxInput,
};

export const penis_skin_color: FeatureToggle = {
  name: 'Penis uses Skin Color',
  component: CheckboxInput,
};

export const penis_color: Feature<string[]> = {
  name: 'Penis Color',
  component: FeatureTriColorInput,
};

export const penis_emissive: Feature<boolean[]> = {
  name: 'Penis Emissives',
  component: FeatureTriBoolInput,
};

export const penis_sheath: Feature<string> = {
  name: 'Penis Sheath',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const penis_length: FeatureNumeric = {
  name: 'Penis Length',
  component: FeatureNumberInput,
};

export const penis_girth: FeatureNumeric = {
  name: 'Penis Girth',
  component: FeatureNumberInput,
};

export const penis_taur_mode_toggle: FeatureToggle = {
  name: 'Penis Taur Mode',
  component: CheckboxInput,
};

export const feature_testicles: Feature<string> = {
  name: 'Testicles Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const testicles_skin_tone: FeatureToggle = {
  name: 'Testicles uses Skin Tone',
  component: CheckboxInput,
};

export const testicles_skin_color: FeatureToggle = {
  name: 'Testicles uses Skin Color',
  component: CheckboxInput,
};

export const testicles_color: Feature<string[]> = {
  name: 'Testicles Color',
  component: FeatureTriColorInput,
};

export const testicles_emissive: Feature<boolean[]> = {
  name: 'Testicles Emissives',
  component: FeatureTriBoolInput,
};

export const balls_size: FeatureNumeric = {
  name: 'Testicles Size',
  component: FeatureNumberInput,
};

export const feature_vagina: Feature<string> = {
  name: 'Vagina Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const vagina_skin_tone: FeatureToggle = {
  name: 'Vagina uses Skin Tone',
  component: CheckboxInput,
};

export const vagina_skin_color: FeatureToggle = {
  name: 'Vagina uses Skin Color',
  component: CheckboxInput,
};

export const vagina_color: Feature<string[]> = {
  name: 'Vagina Color',
  component: FeatureTriColorInput,
};

export const vagina_emissive: Feature<boolean[]> = {
  name: 'Vagina Emissives',
  component: FeatureTriBoolInput,
};

export const feature_womb: Feature<string> = {
  name: 'Womb Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_breasts: Feature<string> = {
  name: 'Breast Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const breasts_skin_tone: FeatureToggle = {
  name: 'Breasts use Skin Tone',
  component: CheckboxInput,
};

export const breasts_skin_color: FeatureToggle = {
  name: 'Breasts use Skin Color',
  component: CheckboxInput,
};

export const breasts_color: Feature<string[]> = {
  name: 'Breast Color',
  component: FeatureTriColorInput,
};

export const breasts_emissive: Feature<boolean[]> = {
  name: 'Breast Emissives',
  component: FeatureTriBoolInput,
};

export const breasts_lactation_toggle: FeatureToggle = {
  name: 'Breast Lactation',
  component: CheckboxInput,
};

export const breasts_size: Feature<string> = {
  name: 'Breast Size',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_anus: Feature<string> = {
  name: 'Anus Choice',
  component: FeatureDropdownInput,
};

export const body_size: FeatureNumeric = {
  name: 'Body Size',
  component: FeatureNumberInput,
};

export const erp_status_pref: FeatureChoiced = {
  name: 'ERP Status',
  component: FeatureDropdownInput,
};

export const erp_status_pref_nc: FeatureChoiced = {
  name: 'ERP Non-Con Status',
  component: FeatureDropdownInput,
};

export const erp_status_pref_v: FeatureChoiced = {
  name: 'ERP Vore Status',
  component: FeatureDropdownInput,
};

export const erp_status_pref_mechanics: FeatureChoiced = {
  name: 'ERP Mechanical Status',
  component: FeatureDropdownInput,
};
