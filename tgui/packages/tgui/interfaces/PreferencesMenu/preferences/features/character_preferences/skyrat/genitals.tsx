// THIS IS A SKYRAT UI FILE
import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureNumberInput,
  FeatureNumeric,
  FeatureToggle,
  FeatureTriBoolInput,
  FeatureTriColorInput,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const feature_penis: Feature<string> = {
  name: 'Penis Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
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
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const penis_sheath: Feature<string> = {
  name: 'Penis Sheath',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const penis_length: FeatureNumeric = {
  name: 'Penis Length',
  description:
    'Value is measured in inches.\
     This value is limited to 20 for characters with a body size <= 1, \
     or without the oversized trait. The maximum allowed value scales up\
     based on the body size of a character, up to a max of 36.',
  component: FeatureNumberInput,
};

export const penis_girth: FeatureNumeric = {
  name: 'Penis Girth',
  description:
    'Value is circumference, measured in inches.\
    This value is limited to 15 for characters with a body size <= 1, \
    or without the oversized trait. The maximum allowed value scales up\
    based on the body size of a character, up to a max of 20.',
  component: FeatureNumberInput,
};

export const penis_taur_mode_toggle: FeatureToggle = {
  name: 'Penis Taur Mode',
  description:
    'If the chosen taur body has a penis sprite, it will be used \
    instead of the usual.',
  component: CheckboxInput,
};

export const feature_testicles: Feature<string> = {
  name: 'Testicles Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
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
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const balls_size: FeatureNumeric = {
  name: 'Testicles Size',
  component: FeatureNumberInput,
};

export const feature_vagina: Feature<string> = {
  name: 'Vagina Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
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
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const feature_womb: Feature<string> = {
  name: 'Womb Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_breasts: Feature<string> = {
  name: 'Breast Choice',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
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
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const breasts_lactation_toggle: FeatureToggle = {
  name: 'Breast Lactation',
  component: CheckboxInput,
};

export const breasts_size: Feature<string> = {
  name: 'Breast Size',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
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
  description:
    'All ERP status preferences are merely markers to other players of \
  your preference towards various broad categories of ERP. Selecting no will virtually isolate you from \
  all directed ERP.',
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

export const erp_status_pref_hypnosis: FeatureChoiced = {
  name: 'ERP Hypnosis Status',
  component: FeatureDropdownInput,
};

export const erp_status_pref_mechanics: FeatureChoiced = {
  name: 'ERP Mechanical Status',
  component: FeatureDropdownInput,
};
