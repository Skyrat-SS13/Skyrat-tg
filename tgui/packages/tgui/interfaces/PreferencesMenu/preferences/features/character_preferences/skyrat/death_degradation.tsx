import { FeatureChoiced, FeatureDropdownInput, Feature, FeatureColorInput, FeatureTextInput, FeatureShortTextInput, CheckboxInput, FeatureTriColorInput, FeatureTriBoolInput, FeatureToggle, FeatureNumberInput, FeatureValueProps, FeatureChoicedServerData } from '../../base';

export const dc_starting_degradation: Feature<number> = {
    name: 'Starting Degradation',
    component: FeatureNumberInput,
    description: 'The degradation you will start with.'
};

export const dc_max_degradation: Feature<number> = {
    name: 'Max Degradation',
    component: FeatureNumberInput,
    description: 'The absolute maximum degradation you can have.'
};

export const dc_living_degradation_recovery_per_second: Feature<number> = {
    name: 'Recovery per second while alive',
    component: FeatureNumberInput,
    description: 'While alive, your degradation will be reduced by this much per second. If negative, this will cause you to slowly die.'
};

export const dc_living_degradation_recovery_per_second: Feature<number> = {
    name: 'Recovery per second while alive',
    component: FeatureNumberInput,
    description: 'While alive, your degradation will be reduced by this much per second. If negative, this will cause you to slowly die.'
};

export const dc_living_degradation_recovery_per_second: Feature<number> = {
    name: 'Recovery per second while alive',
    component: FeatureNumberInput,
    description: 'While alive, your degradation will be reduced by this much per second. If negative, this will cause you to slowly die.'
};

export const dc_dead_degradation_per_second: Feature<number> = {
    name: 'Degradation per second while dead',
    component: FeatureNumberInput,
};

export const dc_degradation_on_death: Feature<number> = {
    name: 'Immediate degradation on death',
    component: FeatureNumberInput,
    description: 'Has a cooldown of around 5 minutes between deaths. '
};

export const dc_formeldahyde_dead_degradation_mult: Feature<number> = {
    name: 'Formeldehyde passive death degradation mult',
    component: FeatureNumberInput,
    description: 'If you are organic and have formeldahyde in your system, any passive degradation caused by being dead will be multiplied against this.'
};

export const dc_rezadone_living_degradation_reduction: Feature<number> = {
    name: 'Pure rezadone degradation reduction',
    component: FeatureNumberInput,
    description: 'If you are organic, alive, and metabolizing rezadone at 100% purity, you will passively recover from degradation at this rate per second.'
};

export const dc_eigenstasium_degradation_reduction: Feature<number> = {
    name: 'Eigenstasium degradation reduction',
    component: FeatureNumberInput,
    description: 'If you have eigenstasium in your system, you will passively recover from degradation at this rate per second. This works for synths, and while dead.'
};

export const dc_crit_threshold_reduction_min_percent_of_max: Feature<number> = {
    name: 'Crit threshold reduction: Beginning degradation percent',
    component: FeatureNumberInput,
    description: 'Crit threshold will begin decreasing when degradation is this percent to max.'
};

export const dc_crit_threshold_reduction_percent_of_max: Feature<number> = {
    name: 'Crit threshold reduction: Ending degradation percent',
    component: FeatureNumberInput,
    description: 'Crit threshold will stop decreasing and reach its maximum reduction when degradation is this percent to max.'
};

export const dc_max_crit_threshold_reduction: Feature<number> = {
    name: 'Crit threshold reduction: Maximum reduction',
    component: FeatureNumberInput,
    description: 'When at the ending degradation percent, crit threshold will be reduced by this, \
	    with lower percentages causing equally displaced reducions, such as having 50% degradation causing 50% of this to be applied.'
};

export const dc_stamina_damage_min_percent_of_max: Feature<number> = {
    name: 'Stamina damage: Beginning degradation percent',
    component: FeatureNumberInput,
    description: 'Minimum stamina damage will start increasing once degradation reaches this percent of maximum.'
};

export const dc_stamina_damage_percent_of_max: Feature<number> = {
    name: 'Stamina damage: Ending degradation percent',
    component: FeatureNumberInput,
    description: 'Minimum stamina damage will reach its maximum possible value once degradation reaches this percent of maximum degradation.'
};

export const dc_max_stamina_damage: Feature<number> = {
    name: 'Stamina damage: Maximum',
    component: FeatureNumberInput,
    description: 'When at the ending degradation percent, your stamina damage will always be at LEAST this, \
    with lower percentages causing equally displaced minimums, such as having 50% degradation with 80 max stamina damage causing a minimum of 40 damage.'
};

export const dc_permakill_at_max: Feature<boolean> = {
    name: 'Permaghost at maximum degradation',
    component: CheckboxInput,
    description: 'If true, you will be permanently ghosted if your degradation reaches its maximum possible value.'
};

export const dc_force_death_if_permakilled: Feature<boolean> = {
    name: 'Force death if permaghosted',
    component: CheckboxInput,
    description: 'If true, you will be permanently killed on permaghost as well.'
};


  
  