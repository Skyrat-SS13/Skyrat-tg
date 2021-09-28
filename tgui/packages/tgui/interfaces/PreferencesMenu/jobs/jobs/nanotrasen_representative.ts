import { Job } from "../base";
import { Captain } from "../departments";

const NanotrasenRepresentative: Job = {
  name: "Nanotrasen Representative",
  description: "Represent Nanotrasen on the station, argue with the HoS about why he can't just field execute people for petty theft, get drunk in your office.",
  department: Captain,
  veteran: true,
  alt_titles: ["Nanotrasen Representative", "Nanotrasen Diplomat", "Central Command Representative"],
};

export default NanotrasenRepresentative;
