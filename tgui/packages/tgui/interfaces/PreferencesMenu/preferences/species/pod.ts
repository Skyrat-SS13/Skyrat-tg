import { Species } from "./base";

const Pod: Species = {
  description: "An ancient, bio-engineered species of sentient plants, \
	created by a Precursor Civilization.",
  features: {
    good: [],
    neutral: [],
    bad: [{
      icon: "ban",
      name: "Uncivilized",
      description: "This species can't be used on the station.",
    }],
  },
};

export default Pod;
