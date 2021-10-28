import { Job } from "../base";
import { Cargo } from "../departments";

const CustomsAgent: Job = {
  name: "Customs Agent",
  description: "Inspect the packages coming to and from the station, protect the cargo department, beat the shit out of people trying to ship \
  Cocaine to the Spinward Stellar Coalition.",
  department: Cargo,
};

export default CustomsAgent;
