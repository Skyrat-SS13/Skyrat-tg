import { createLanguagePerk, Species } from "./base";

const Vox: Species = {
  description: "The Vox are nomadic, bio-engineered alien creatures with a complex society formed by a hierarchy of greater races.\
  Having no home planet, they instead live on giant moon-sized Arkships. As well as smaller, crudely put together space stations in communes.",
  features: {
    good: [{
      icon: "temperature-low",
      name: "Cold Resistance",
      description: "Vox adaptation to their lifestyle in space has resulted in them being immune to freezing tempatures.  \
        temperatures.",
    }, createLanguagePerk("Vox-pidgin")],
    neutral: [

    ],
    bad: [{
      icon: "bolt",
      name: "EMP Vulnerable",
      description: "Vox will take brain damage from exposure to electro magnetic pulses.",
    }, {
      icon: "wind",
      name: "Nitrogen Breathing",
      description: "Vox must breathe nitrogen to survive. You receive a \
      tank when you arrive.",
    }],
  },
  lore: [
    "A loud and shrieking species shrouded in mystery and an epoch of history, Created for the purpose to serve the greater good of their living arkships, Vox are considered some of the oldest species in the universe.",
    "The Vox species can be divided into four groups: Primalis, Armalis, Auralis and Apex. The Primalis respectively constitute the military, trade, and labour divisions in Vox society, as well as rare positions of power. Vox Primalis are ultimately lead by the Auralis whom use their artificial subordinates to ensure the society is functioning. Using the Apex  to preserving the sanctity, purity and continuity of the particular Vox lineage its arkship is hosting. The Armalis as a subservant proxy to enforce their commands on the Primalis, and Primalis as disposable drones and general population in work. the vox society is heavily stratified, each body being made to fit a specific and only one purpose.",
    "Vox lack a homeworld in the most traditional sense, with Vox society instead being encapsulated by massive living arkships, skipjacks, and the Shoal. Each arkship houses a population of at least ten million to half a billion individuals if not more. Due to their size, arkships are largely immobile and are defended almost entirely by an accompanying, much more mobile flotilla. Each arkship tracing the lineage of its inhabitants back several hundred millennia, No two arkships are entirely alike, however, vox from differing arkships may vary in numerous, unique ways.",
    "Each Vox possesses a cortical stack, which stores both the entire consciousness of the Vox, but also its genetic structure. Part of this structure forces the Vox to present an identification and serial code, hijacking the pigment of their hide to do so. A Primalis is not considered truly dead while their stack is in condition to be transplanted into a new  bioplasmic vessel, giving Vox the advantage of being immortal if a stack is preserved.",
  ],
};

export default Vox;
