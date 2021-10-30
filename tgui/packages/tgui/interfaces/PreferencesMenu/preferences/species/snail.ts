import { Species } from "./base";

const Snail: Species = {
  description: "A race that is slimy and has a shell. Though they can walk, they prefer to crawl on the ground.\
                They are weak to a few things though, so be cautious when around them.",
  features: {
    good: [

    ],
    neutral: [{
      icon: "fist-raised",
      name: "Shell",
      description: "Snails have a shell.",
    }],
    bad: [{
      icon: "fist-raised",
      name: "Salt Weakness",
      description: "Snails are weak to salt and will start taking damage if they have ingested salt.",
    }, {
      icon: "fist-raised",
      name: "Slow",
      description: "Snails are slow crawlers, and even slower walkers.",
    }, {
      icon: "fist-raised",
      name: "Weak fists",
      description: "Snails are squishy, and don't hit hard at all.",
    }, {
      icon: "fist-raised",
      name: "Eletricity Weakness",
      description: "Snails are mainly liquids \
        and will be shocked harder.",
    }, {
      icon: "temperature-low",
      name: "Cold Strength",
      description: "Snails are have some tolerance for cold \
        temperatures.",
    }, {
      icon: "temperature-high",
      name: "Heat Weakness",
      description: "Snails have a much lower tolerance for hot \
        temperatures.",
    }],
  },
  lore: [
    "Snails are just snails. Some are still very slow mentally, others are starting to become smarter.",
  ],
};

export default Snail;
