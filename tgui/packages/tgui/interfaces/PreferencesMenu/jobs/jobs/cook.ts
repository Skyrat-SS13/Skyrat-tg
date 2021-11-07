import { Job } from "../base";
import { Service } from "../departments";

const Cook: Job = {
  name: "Cook",
  description: "Serve food, cook meat, keep the crew fed.",
  department: Service,
  alt_titles: ["Cook", "Chef", "Butcher", "Culinary Artist", "Sous-Chef"],
};

export default Cook;
