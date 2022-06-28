export enum Gender {
  Male = 'male',
  Female = 'female',
  Other = 'plural',
}

export const GENDERS = {
  [Gender.Male]: {
    icon: 'male',
    text: 'Male',
  },

  [Gender.Female]: {
    icon: 'female',
    text: 'Female',
  },

  [Gender.Other]: {
    icon: 'question', // SKYRAT EDIT CHANGE - ORIGINAL: icon: "tg-non-binary"
    text: 'Other',
  },
};
