import { Species } from "./base";

const Pod: Species = {
  description: "An ancient, bio-engineered species of sentient plants, \
	created by a Precursor Civilization.",
  features: {
    good: [{
      icon: "sun",
      name: "Photosynthetic Restoration",
      description: "Podpeople slowly regenerate their wounds, \
      clear out toxins, gather oxygen, and gain nutrition when in \
      lit areas.",
    }],
    neutral: [],
    bad: [{
      icon: "ban",
      name: "Uncivilized",
      description: "This species can't be used on the station.",
    }, {
      icon: "seedling",
      name: "Wilting",
      description: "When hungry, podpeople start taking damage.",
    }, {
      icon: "heart-broken",
      name: "Weak",
      description: "Podpeople take increased brute and burn damage.",
    }],
  },
};

export default Pod;
