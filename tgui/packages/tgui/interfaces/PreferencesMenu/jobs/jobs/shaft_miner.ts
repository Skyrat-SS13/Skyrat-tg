import { Job } from "../base";
import { Cargo } from "../departments";

const ShaftMiner: Job = {
  name: "Shaft Miner",
  description: "Travel to strange lands. Mine ores. \
    Meet strange creatures. Kill them for their gold.",
  department: Cargo,
  alt_titles: ["Shaft Miner", "Excavator"],
};

export default ShaftMiner;
