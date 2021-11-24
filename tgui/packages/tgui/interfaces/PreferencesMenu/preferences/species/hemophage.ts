import { Species } from "./base";

const Hemophage: Species = {
  description: "A crewmember afflicted with Hemophagia. Whether it's supernatural or purely through science, is still unknown.",
  features: {
    good: [{
      icon: "bed",
      name: "Locker Brooding",
      description: "Hemophages can delay their Thirst and mend their injuries by \
        resting in a sturdy rectangular-shaped object. So THAT'S why they do that!",
    }, {
      icon: "skull",
      name: "Viral Symbiosis",
      description: "Hemophages, due to their condition, cannot get infected by \
        other viruses and don't actually require an external source of oxygen \
        to stay alive.",
    }, {
      icon: "recycle",
      name: "Bat Form",
      description: "During Halloween, Hemophages can become bats. Bats are very weak, but \
        are great for escaping bad situations. They can also travel through \
        vents, giving Hemophages a lot of access. Just remember that access \
        doesn't equal permission, and people may be unhappy with you showing \
        up uninvited!",
    }],
    neutral: [],
    bad: [{
      icon: "tint",
      name: "The Thirst",
      description: "In place of eating, Hemophages suffer from the Thirst. \
      Thirst of what? Blood! Their tongue allows them to grab people and drink \
      their blood, and they will suffer severe consequences if they run out. As a note, it doesn't \
      matter whose blood you drink, it will all be converted into your blood \
      type when consumed.",
    },
    {
      icon: "cross",
      name: "Against God and Nature",
      description: "During Halloween, almost all higher powers are disgusted by the existence of \
      Hemophages, and entering the chapel is essentially suicide. Do not do it!",
    }],
  },
  lore: [
    "Though known by many other names, 'Hemophages' are those that have found themselves the host of a bloodthirsty infection. Initially entering their hosts through the bloodstream, or activating after a period of dormancy in infants, this infection initially travels to the chest first. Afterwards, it infects several cells, making countless alterations to their genetic sequence, until it starts rapidly expanding and taking over every nearby organ, notably the heart, lungs, and stomach, forming a massive tumor vaguely reminiscent of an overgrown, coal-black heart, that hijacks them for its own benefit, and in exchange, allows the host to 'sense' the quality, and amount of blood currently occupying their body.", 
    "While this kills the host initially, the tumor will jumpstart the body and begin functioning as a surrogate to keep their host going. This does confer certain advantages to the host, in the interest of keeping them alive; working anaerobically, requiring no food to function, and extending their lifespan dramatically. However, this comes at a cost, as the tumor changes their host into an obligate hemophage; only the enzymes, and iron in blood being able to fuel them. If they are to run out of blood, the tumor will begin consuming its own host.",
    "Historically, Hemophages have caused great societal strife through their very existence. Many have reported dread on having someone reveal they require blood to survive, worse on learning they have been undead, espiecally in 'superstitious' communities. In many places they occupy a sort of second class, unable to live normal lives due to their condition being a sort of skeleton in their closet. Some can actually be found in slaughterhouses or the agricultural industry, gaining easy access to a large supply of animal blood to feed their eternal thirst.", 
    "Others find their way into mostly-vampiric communities, turning others into their own kind; though, the virus can only transmit to hosts that are incredibly low on blood, taking advantage of their reduced immune system efficiency and higher rate of blood creation to be able to survive the initial few days within their host.",
    "\"What the fuck does any of this mean?\" - Doctor Micheals, reading their CentCom report about the new 'hires'.",
  ],
};

export default Hemophage;
