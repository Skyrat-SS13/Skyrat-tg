export enum Gender {
  Male = 'male',
  Female = 'female',
  Other = 'plural',
  Other2 = 'neuter',
}

export const GENDERS = {
  [Gender.Male]: {
    icon: 'male',
    text: 'He/Him', // SKYRAT EDIT START - It/Its Pronouns
  },

  [Gender.Female]: {
    icon: 'female',
    text: 'She/Her',
  },

  [Gender.Other]: {
    icon: 'question', // SKYRAT EDIT CHANGE - ORIGINAL: icon: "tg-non-binary"
    text: 'They/Them',
  },

  [Gender.Other2]: {
    icon: 'tg-non-binary',
    text: 'It/Its', // SKYRAT EDIT END - It/Its Pronouns
  },
};
