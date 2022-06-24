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
<<<<<<< HEAD
    icon: "question", // SKYRAT EDIT CHANGE - ORIGINAL: icon: "tg-non-binary"
    text: "Other",
=======
    icon: 'tg-non-binary',
    text: 'Other',
>>>>>>> 731ab29aa73 (Adds Prettierx - or how I broke TGUI for the nth time (#67935))
  },
};
