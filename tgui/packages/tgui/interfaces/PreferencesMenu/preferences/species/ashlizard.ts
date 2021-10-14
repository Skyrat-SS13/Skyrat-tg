import { Species } from "./base";

const Ashwalker: Species = {
  description: "The primitive natives of Indecipheres, this race, \
    remotely related to other spacefaring reptiles, has formed a \
    symbiotic relationship with one of the tendrils of the Necropolis. \
    They live in a delicate balance with their surroundings, \
    now threatened by invaders from the stars...",
  features: {
    good: [{
      icon: "shield-alt",
      name: "Tough Scales",
      description: "Ash Walkers have been toughened by the heat of \
        their homeland and constant hunting, making them more \
        resilient to damage.",
    }, {
      icon: "biohazard",
      name: "Virus Immunity",
      description: "Either a blessing of the Tendril or unnaturally \
        strong immune systems, Ash Walkers cannot contract illnesses.",
    }, {
      icon: "low-vision",
      name: "Darksight",
      description: "The eyes of Ash Walkers are able to see in \
        the dark.",
    }, {
      icon: "wind",
      name: "Blackened Lungs",
      description: "The lungs of Ash Walkers are able to breathe \
        the soot-filled atmosphere of Indecipheres.",
    }],
    neutral: [{
      icon: "thermometer-empty",
      name: "Cold-blooded",
      description: "Higher tolerance for high temperatures, but lower \
        tolerance for cold temperatures.",
    }, {
      icon: "egg",
      name: "Tendril Rebirth",
      description: "Ash Walkers may be brought back to life by \
        the tendril they worship... as long as suitable \
        sacrifices are made.",
    }],
    bad: [{
      icon: "ban",
      name: "Uncivilized",
      description: "This species can't be used on the station.",
    }, {
      icon: "tint",
      name: "Exotic Blood",
      description: "Lizards have a unique \"L\" type blood, which can make \
        receiving medical treatment more difficult.",
    }],
  },
};

export default Ashwalker;
