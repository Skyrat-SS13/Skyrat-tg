import { Job } from "../base";
import { Engineering } from "../departments";

const ChiefEngineer: Job = {
  name: "Chief Engineer",
  description: "Coordinate engineering, ensure equipment doesn't get stolen, \
    make sure the Supermatter doesn't blow up, maintain telecommunications.",
  department: Engineering,
  alt_titles: ["Chief Engineer", "Engineering Foreman"],
};

export default ChiefEngineer;
