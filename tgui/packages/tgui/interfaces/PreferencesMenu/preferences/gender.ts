export enum Gender {
  Male = 'male',
  Female = 'female',
  Other = 'plural',
  Other2 = 'neuter',
}

export const GENDERS = {
  [Gender.Male]: {
    icon: 'mars',
    text: 'He/Him',
  },

  [Gender.Female]: {
    icon: 'venus',
    text: 'She/Her',
  },

  [Gender.Other]: {
<<<<<<< HEAD
    icon: 'question', // SKYRAT EDIT CHANGE - ORIGINAL: icon: "tg-non-binary"
    text: 'Other',
=======
    icon: 'transgender',
    text: 'They/Them',
  },

  [Gender.Other2]: {
    icon: 'neuter',
    text: 'It/Its',
>>>>>>> 823b9a53a59 (Adds support for it/its pronouns (#76799))
  },
};
