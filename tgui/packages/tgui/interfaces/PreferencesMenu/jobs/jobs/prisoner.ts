import { Job } from "../base";
import { Security } from "../departments";

const Prisoner: Job = {
  name: "Prisoner",
  description: "Keep yourself occupied while in permabrig.",
  department: Security,
  alt_titles: ["Prisoner", "Minimum Security Prisoner", "Maximum Security Prisoner", "SuperMax Security Prisoner", "Protective Custody Prisoner"],
};

export default Prisoner;
