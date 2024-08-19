// THIS IS A SKYRAT UI FILE
import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureColorInput,
  FeatureNumberInput,
  FeatureShortTextInput,
  FeatureTextInput,
  FeatureToggle,
  FeatureTriBoolInput,
  FeatureTriColorInput,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const feature_leg_type: FeatureChoiced = {
  name: 'Leg type',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_mcolor2: Feature<string> = {
  name: 'Mutant color 2',
  component: FeatureColorInput,
};
export const feature_mcolor3: Feature<string> = {
  name: 'Mutant color 3',
  component: FeatureColorInput,
};

export const flavor_text: Feature<string> = {
  name: 'Flavor Text',
  description:
    "Appears when your character is examined (but only if they're identifiable - try a gas mask).",
  component: FeatureTextInput,
};

export const silicon_flavor_text: Feature<string> = {
  name: 'Flavor Text (Silicon)',
  description: "Only appears if you're playing as a borg/AI.",
  component: FeatureTextInput,
};

export const ooc_notes: Feature<string> = {
  name: 'OOC Notes',
  component: FeatureTextInput,
};

export const custom_species: Feature<string> = {
  name: 'Custom Species Name',
  description:
    'Appears on examine. If left blank, you will use your default species name (E.g. Human, Lizardperson).',
  component: FeatureShortTextInput,
};

export const custom_species_lore: Feature<string> = {
  name: 'Custom Species Lore',
  description: "Won't show up if there's no custom species.",
  component: FeatureTextInput,
};

export const custom_taste: Feature<string> = {
  name: 'Character Taste',
  description: 'How does your character taste if someone licks them.',
  component: FeatureShortTextInput,
};

export const custom_smell: Feature<string> = {
  name: 'Character Smell',
  description: 'How does your character smell if someone sniffs them.',
  component: FeatureShortTextInput,
};

export const general_record: Feature<string> = {
  name: 'Records - General',
  description:
    'Viewable with any records access. \
    For general viewing-things like employment, qualifications, etc.',
  component: FeatureTextInput,
};

export const security_record: Feature<string> = {
  name: 'Records - Security',
  description:
    'Viewable with security access. \
  For criminal records, arrest history, things like that.',
  component: FeatureTextInput,
};

export const medical_record: Feature<string> = {
  name: 'Records - Medical',
  description:
    'Viewable with medical access. \
  For things like medical history, prescriptions, DNR orders, etc.',
  component: FeatureTextInput,
};

export const exploitable_info: Feature<string> = {
  name: 'Records - Exploitable',
  description:
    'Can be IC or OOC. Viewable by certain antagonists/OPFOR users, as well as ghosts. Generally contains \
  things like weaknesses, strengths, important background, trigger words, etc. It ALSO may contain things like \
  antagonist preferences, e.g. if you want to be antagonized, by whom, with what, etc.',
  component: FeatureTextInput,
};

export const background_info: Feature<string> = {
  name: 'Records - Background',
  description:
    'Only viewable by yourself and ghosts. You can have whatever you want in here - it may be valuable as a way to orient yourself to what your character is.',
  component: FeatureTextInput,
};

export const pda_ringer: Feature<string> = {
  name: 'PDA Ringer Message',
  description:
    'Want your PDA to say something other than "beep"? Accepts the first 20 characters.',
  component: FeatureShortTextInput,
};

export const allow_mismatched_parts_toggle: FeatureToggle = {
  name: 'Allow Mismatched Parts',
  description: 'Allows parts from any species to be picked.',
  component: CheckboxInput,
};

export const allow_mismatched_hair_color_toggle: FeatureToggle = {
  name: 'Allow Mismatched Hair Color',
  description:
    'Allows species who normally have a fixed hair color to have different hair colors. This includes in-round sources such as dyeing hair, alter form, etc. Currently only applicable to slimes.',
  component: CheckboxInput,
};

export const allow_genitals_toggle: FeatureToggle = {
  name: 'Allow Genital Parts',
  description: 'Enables if you want to have genitals on your character.',
  component: CheckboxInput,
};

export const allow_emissives_toggle: FeatureToggle = {
  name: 'Allow Emissives',
  description: 'Emissive parts glow in the dark.',
  component: CheckboxInput,
};

export const eye_emissives: FeatureToggle = {
  name: 'Eye Emissives',
  description: 'Emissive parts glow in the dark.',
  component: CheckboxInput,
};

export const mutant_colors_color: Feature<string[]> = {
  name: 'Mutant Colors',
  component: FeatureTriColorInput,
};

export const body_markings_toggle: FeatureToggle = {
  name: 'Body Markings',
  component: CheckboxInput,
};

export const feature_body_markings: Feature<string> = {
  name: 'Body Markings Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const body_markings_color: Feature<string[]> = {
  name: 'Body Markings Colors',
  component: FeatureTriColorInput,
};

export const body_markings_emissive: Feature<boolean[]> = {
  name: 'Body Markings Emissives',
  component: FeatureTriBoolInput,
};

export const tail_toggle: FeatureToggle = {
  name: 'Tail',
  component: CheckboxInput,
};

export const feature_tail: Feature<string> = {
  name: 'Tail Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const tail_color: Feature<string[]> = {
  name: 'Tail Colors',
  component: FeatureTriColorInput,
};

export const tail_emissive: Feature<boolean[]> = {
  name: 'Tail Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const snout_toggle: FeatureToggle = {
  name: 'Snout',
  component: CheckboxInput,
};

export const feature_snout: Feature<string> = {
  name: 'Snout Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const snout_color: Feature<string[]> = {
  name: 'Snout Colors',
  component: FeatureTriColorInput,
};

export const snout_emissive: Feature<boolean[]> = {
  name: 'Snout Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const horns_toggle: FeatureToggle = {
  name: 'Horns',
  component: CheckboxInput,
};

export const feature_horns: Feature<string> = {
  name: 'Horns Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const horns_color: Feature<string[]> = {
  name: 'Horns Colors',
  component: FeatureTriColorInput,
};

export const horns_emissive: Feature<boolean[]> = {
  name: 'Horns Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const ears_toggle: FeatureToggle = {
  name: 'Ears',
  component: CheckboxInput,
};

export const feature_ears: Feature<string> = {
  name: 'Ears Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ears_color: Feature<string[]> = {
  name: 'Ears Colors',
  component: FeatureTriColorInput,
};

export const ears_emissive: Feature<boolean[]> = {
  name: 'Ears Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const wings_toggle: FeatureToggle = {
  name: 'Wings',
  component: CheckboxInput,
};

export const feature_wings: Feature<string> = {
  name: 'Wings Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const wings_color: Feature<string[]> = {
  name: 'Wings Colors',
  component: FeatureTriColorInput,
};

export const wings_emissive: Feature<boolean[]> = {
  name: 'Wings Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const frills_toggle: FeatureToggle = {
  name: 'Frills',
  component: CheckboxInput,
};

export const feature_frills: Feature<string> = {
  name: 'Frills Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const frills_color: Feature<string[]> = {
  name: 'Frills Colors',
  component: FeatureTriColorInput,
};

export const frills_emissive: Feature<boolean[]> = {
  name: 'Frills Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const spines_toggle: FeatureToggle = {
  name: 'Spines',
  component: CheckboxInput,
};

export const feature_spines: Feature<string> = {
  name: 'Spines Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const spines_color: Feature<string[]> = {
  name: 'Spines Colors',
  component: FeatureTriColorInput,
};

export const spines_emissive: Feature<boolean[]> = {
  name: 'Spines Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const digitigrade_legs: FeatureChoiced = {
  name: 'Legs',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const caps_toggle: FeatureToggle = {
  name: 'Cap',
  component: CheckboxInput,
};

export const feature_caps: Feature<string> = {
  name: 'Cap Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const caps_color: Feature<string[]> = {
  name: 'Cap Colors',
  component: FeatureTriColorInput,
};

export const caps_emissive: Feature<boolean[]> = {
  name: 'Caps Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const moth_antennae_toggle: FeatureToggle = {
  name: 'Moth Antenna',
  component: CheckboxInput,
};

export const feature_moth_antennae: Feature<string> = {
  name: 'Moth Antenna Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const moth_antennae_color: Feature<string[]> = {
  name: 'Moth Antenna Colors',
  component: FeatureTriColorInput,
};

export const moth_antennae_emissive: Feature<boolean[]> = {
  name: 'Moth Antenna Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const moth_markings_toggle: FeatureToggle = {
  name: 'Moth Markings',
  component: CheckboxInput,
};

export const feature_moth_markings: Feature<string> = {
  name: 'Moth Markings Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const moth_markings_color: Feature<string[]> = {
  name: 'Moth Markings Colors',
  component: FeatureTriColorInput,
};

export const moth_markings_emissive: Feature<boolean[]> = {
  name: 'Moth Markings Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const fluff_toggle: FeatureToggle = {
  name: 'Fluff',
  component: CheckboxInput,
};

export const feature_fluff: Feature<string> = {
  name: 'Fluff Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const fluff_color: Feature<string[]> = {
  name: 'Fluff Colors',
  component: FeatureTriColorInput,
};

export const fluff_emissive: Feature<boolean[]> = {
  name: 'Fluff Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const head_acc_toggle: FeatureToggle = {
  name: 'Head Accessories',
  component: CheckboxInput,
};

export const feature_head_acc: Feature<string> = {
  name: 'Head Accessories Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const head_acc_color: Feature<string[]> = {
  name: 'Head Accessories Colors',
  component: FeatureTriColorInput,
};

export const head_acc_emissive: Feature<boolean[]> = {
  name: 'Head Accessories Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const feature_ipc_screen: Feature<string> = {
  name: 'IPC Screen Selection',
  description: 'Can be changed in-round.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_screen_color: Feature<string> = {
  name: 'IPC Screen Greyscale Color',
  component: FeatureColorInput,
};

export const ipc_screen_emissive: Feature<boolean> = {
  name: 'IPC Screen Emissive',
  description: 'Emissive parts glow in the dark.',
  component: CheckboxInput,
};

export const ipc_antenna_toggle: FeatureToggle = {
  name: 'Synth Antenna',
  component: CheckboxInput,
};

export const feature_ipc_antenna: Feature<string> = {
  name: 'Synth Antenna Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_antenna_color: Feature<string[]> = {
  name: 'Synth Antenna Colors',
  component: FeatureTriColorInput,
};

export const ipc_antenna_emissive: Feature<boolean[]> = {
  name: 'Synth Antenna Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const feature_ipc_chassis: Feature<string> = {
  name: 'Synth Chassis Selection',
  description: 'Only works for synths.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_chassis_color: Feature<string> = {
  name: 'Synth Chassis Colors',
  description:
    'Only works for Synths and chassis that support greyscale coloring.',
  component: FeatureColorInput,
};

export const feature_ipc_head: Feature<string> = {
  name: 'Synth Head Selection',
  description: 'Only works for Synths.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_head_color: Feature<string> = {
  name: 'Synth Head Colors',
  component: FeatureColorInput,
};

export const feature_hair_opacity_toggle: Feature<boolean> = {
  name: 'Hair Opacity Override',
  component: CheckboxInput,
};

export const feature_hair_opacity: Feature<number> = {
  name: 'Hair Opacity',
  component: FeatureNumberInput,
};

export const neck_acc_toggle: FeatureToggle = {
  name: 'Neck Accessories',
  component: CheckboxInput,
};

export const feature_neck_acc: Feature<string> = {
  name: 'Neck Accessories Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const neck_acc_color: Feature<string[]> = {
  name: 'Neck Accessories Colors',
  component: FeatureTriColorInput,
};

export const neck_acc_emissive: Feature<boolean[]> = {
  name: 'Neck Accessories Emissives',
  component: FeatureTriBoolInput,
};

export const skrell_hair_toggle: FeatureToggle = {
  name: 'Skrell Hair',
  component: CheckboxInput,
};

export const feature_skrell_hair: Feature<string> = {
  name: 'Skrell Hair Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const skrell_hair_color: Feature<string[]> = {
  name: 'Skrell Hair Colors',
  component: FeatureTriColorInput,
};

export const skrell_hair_emissive: Feature<boolean[]> = {
  name: 'Skrell Hair Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const taur_toggle: FeatureToggle = {
  name: 'Taur',
  component: CheckboxInput,
};

export const feature_taur: Feature<string> = {
  name: 'Taur Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const taur_color: Feature<string[]> = {
  name: 'Taur Colors',
  component: FeatureTriColorInput,
};

export const taur_emissive: Feature<boolean[]> = {
  name: 'Taur Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const naga_sole: FeatureToggle = {
  name: 'Taur (Naga) disable hardened soles',
  description:
    'If using a serpentine taur body, determines if you are immune to caltrops and a few other effects of being barefoot.',
  component: CheckboxInput,
};

export const xenodorsal_toggle: FeatureToggle = {
  name: 'Xenodorsal',
  component: CheckboxInput,
};

export const feature_xenodorsal: Feature<string> = {
  name: 'Xenodorsal Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const xenodorsal_color: Feature<string[]> = {
  name: 'Xenodorsal Colors',
  component: FeatureTriColorInput,
};

export const xenodorsal_emissive: Feature<boolean[]> = {
  name: 'Xenodorsal Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const xenohead_toggle: FeatureToggle = {
  name: 'Xeno Head',
  component: CheckboxInput,
};

export const feature_xenohead: Feature<string> = {
  name: 'Xeno Head Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const xenohead_color: Feature<string[]> = {
  name: 'Xeno Head Colors',
  component: FeatureTriColorInput,
};

export const xenohead_emissive: Feature<boolean[]> = {
  name: 'Xeno Head Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const undershirt_color: Feature<string> = {
  name: 'Undershirt color',
  component: FeatureColorInput,
};

export const socks_color: Feature<string> = {
  name: 'Socks color',
  component: FeatureColorInput,
};

export const heterochromia_toggle: FeatureToggle = {
  name: 'Heterochromia',
  component: CheckboxInput,
};

export const feature_heterochromia: Feature<string> = {
  name: 'Heterochromia Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const heterochromia_color: Feature<string[]> = {
  name: 'Heterochromia Colors',
  component: FeatureTriColorInput,
};

export const heterochromia_emissive: Feature<boolean[]> = {
  name: 'Heterochromia Emissives',
  description: 'Emissive parts glow in the dark.',
  component: FeatureTriBoolInput,
};

export const vox_bodycolor: Feature<string> = {
  name: 'Vox Bodycolor',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const pod_hair_color: Feature<string[]> = {
  name: 'Floral Hair Color',
  component: FeatureTriColorInput,
};

export const pod_hair_emissive: Feature<boolean> = {
  name: 'Floral Hair Emissive',
  description: 'Emissive parts glow in the dark.',
  component: CheckboxInput,
};
