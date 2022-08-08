import { FeatureToggle, CheckboxInput } from '../../base';

export const auto_dementor_pref: FeatureToggle = {
  name: 'Auto dementor',
  category: 'ADMIN',
  description: 'When enabled, you will automatically dementor.',
  component: CheckboxInput,
};

export const delete_sparks_pref: FeatureToggle = {
  name: 'Deletion sparks',
  category: 'ADMIN',
  description:
    'Toggles if you want to play a sparking animation when deleting things as an admin.',
  component: CheckboxInput,
};

export const looc_admin_pref: FeatureToggle = {
  name: 'See admin LOOC',
  category: 'ADMIN',
  description:
    'Toggles whether you want to see LOOC anywhere as an admin or not.',
  component: CheckboxInput,
};

export const ticket_ping_pref: FeatureToggle = {
  name: 'Ticket ping',
  category: 'ADMIN',
  description:
    'When enabled, you will recieve regular pings from unhandled tickets.',
  component: CheckboxInput,
};

export const ooc_admin_tag: FeatureToggle = {
  name: 'OOC admin tag',
  category: 'ADMIN',
  description: 'Toggles if you want an admin tag in your OOC name.',
  component: CheckboxInput,
};
