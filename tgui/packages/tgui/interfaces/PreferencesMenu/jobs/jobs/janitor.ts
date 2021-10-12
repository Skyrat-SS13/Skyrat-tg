import { Job } from "../base";
import { Service } from "../departments";

const Janitor: Job = {
  name: "Janitor",
  description: "Clean up trash and blood. Replace broken lights. \
    Slip people over.",
  department: Service,
  alt_titles: ["Janitor", "Custodian", "Custodial Technicial", "Sanitation Technician", "Maid"],
};

export default Janitor;
