/** Radio channels */
export const CHANNELS = ['Say', 'Radio', 'Me', 'OOC'] as const;

/** Window sizes in pixels */
export enum WINDOW_SIZES {
  small = 30,
  medium = 50,
  large = 70,
  width = 231,
}

/** Line lengths for autoexpand */
export enum LINE_LENGTHS {
  small = 20,
  medium = 35,
}

/**
 * Radio prefixes.
 * Contains the properties:
 * id - string. css class identifier.
 * label - string. button label.
 */
export const RADIO_PREFIXES = {
  ':a ': {
    id: 'hive',
    label: 'Hive',
  },
  ':b ': {
    id: 'binary',
    label: '0101',
  },
  ':c ': {
    id: 'command',
    label: 'Cmd',
  },
  ':e ': {
    id: 'engi',
    label: 'Engi',
  },
  ':m ': {
    id: 'medical',
    label: 'Med',
  },
  ':n ': {
    id: 'science',
    label: 'Sci',
  },
  ':o ': {
    id: 'ai',
    label: 'AI',
  },
  ':s ': {
    id: 'security',
    label: 'Sec',
  },
  ':t ': {
    id: 'syndicate',
    label: 'Syndi',
  },
  ':u ': {
    id: 'supply',
    label: 'Supp',
  },
  ':v ': {
    id: 'service',
    label: 'Svc',
  },
  ':y ': {
    id: 'centcom',
    label: 'CCom',
  },
  ':w ': {
    id: 'interdyne',
    label: 'Intdyn',
  },
  ':q ': {
    id: 'cybersun',
    label: 'Cyber',
  },
  ':g ': {
    id: 'guild',
    label: 'Guild',
  },
  ':k ': {
    id: 'tarkon',
    label: 'Tarkon',
  },
} as const;
