import { Feature, FeatureNumberInput } from '../base';

export const age: Feature<number> = {
<<<<<<< HEAD
  // name: 'Age', // ORIGINAL
  name: 'Age (Physical)', // SKYRAT EDIT CHANGE - Chronological age
  // SKYRAT EDIT ADDITION BEGIN - Chronological age
  description:
    "Physical age represents how far your character has grown physically and mentally.\
    Includes 'normal' aging, such as experiences which physically age the body, and 'anti-aging' medical procedures.\
    Does not include time spent in cryo-sleep.",
  // SKYRAT EDIT ADDITION END
=======
  name: 'Age',
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
  component: FeatureNumberInput,
};
