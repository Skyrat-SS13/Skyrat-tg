import { Species } from "./base";

const Vampire: Species = {
  description: "A crewmember afflicted with 'Vampirism', whether it's supernatural or purely through science, is still unknown."",
  features: {
    good: [{
      icon: "bed",
      name: "Locker Brooding",
      description: "Vampires can delay The Thirst and heal by resting in a \
        coffin. So THAT'S why they do that!",
    }, {
      icon: "skull",
      name: "Minor Undead",
      description: "Vampires can delay their thirst and heal by resting in any \
        locker. Useful, not entirely practical, though.",
    }, {
      icon: "recycle",
      name: "Bat Form",
      description: "Vampires can become bats (During halloween). Bats are very weak, but \
        are great for escaping bad situations. They can also travel through \
        vents, giving Vampires a lot of access. Just remember that access \
        doesn't equal permission, and people may be unhappy with you showing \
        up uninvited!",
    }],
    neutral: [],
    bad: [{
      icon: "tint",
      name: "The Thirst",
      description: "In place of eating, vampires suffer from The Thirst. \
      Thirst of what? Blood! Their tongue allows them to grab people and drink \
      their blood, and they will suffer severe consequences if they run out. As a note, it doesn't \
      matter whose blood you drink, it will all be converted into your blood \
      type when consumed.",
    },
    {
      icon: "cross",
      name: "Against God and Nature",
      description: "(During halloween) Almost all higher powers are disgusted by the existence of \
      vampires, and entering the chapel is essentially suicide. Do not do it!",
    }],
  },
  lore: [
        "Vampires are ambiguous beings, but the one side effect they generally agree on is, The Thirst. The Thirst requires them to feast on blood to maintain their bodies health, and in return it gives them many bonuses. Because of this, Vampires have split into two clans, one that embraces their powers as a blessing and one that rejects it.",
    "\"What the fuck does any of this mean\" - Doctor Micheals, reading their centcomm report about the new 'hires'.",
  ],
};

export default Vampire;
