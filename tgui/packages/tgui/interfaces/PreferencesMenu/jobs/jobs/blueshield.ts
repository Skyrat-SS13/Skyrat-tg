import { Job } from "../base";
import { Captain } from "../departments";

const Blueshield: Job = {
  name: "Blueshield",
  description: "Protect heads of staff, get your fancy gun stolen, cry as the captain touches the supermatter.",
  department: Captain,
  veteran: true,
  alt_titles: ["Blueshield", "Command Bodyguard", "Executive Protection Agent"],
};

export default Blueshield;
