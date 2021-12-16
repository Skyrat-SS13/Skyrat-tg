import { createLanguagePerk, Species } from "./base";

const Teshari: Species = {
  description: "A race of feathered raptors who developed on a cold-climated planet. Their small size\
                makes them rather fragile, and while their feathered coat provides them with protection against cold\
                it also makes them more susceptible to burns and heat.",
  features: {
    good: [{
      icon: "temperature-low",
      name: "Cold Resistance",
      description: "Teshari have much better tolerance for low \
        temperatures.",
    }, createLanguagePerk("Schechi")],
    neutral: [
      
    ],
    bad: [{
      icon: "fist-raised",
      name: "Brute and Burn Weakness",
      description: "Teshari are weak to brute and burn damage.",
    }, {
      icon: "fist-raised",
      name: "Weakness",
      description: "Teshari deal less unarmed attack damage due to their small size.",
    }, {
      icon: "temperature-high",
      name: "Heat Weakness",
      description: "Teshari have much lower tolerance for hot \
        temperatures.",
    }],
  },
  lore: [
    "Teshari lore TBD. For visual reference, see https://avali.fandom.com/wiki/Art_%26_Concepts (The lore of this wiki does not apply to Teshari.)\
     Hairstyles likely won't look great on Teshari, it is recommended you stick to the styles built in on the various custom-tailored ear sprites!",
  ],
};

export default Teshari;
