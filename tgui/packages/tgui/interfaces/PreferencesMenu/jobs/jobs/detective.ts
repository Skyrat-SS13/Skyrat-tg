import { Job } from "../base";
import { Security } from "../departments";

const Detective: Job = {
  name: "Detective",
  description: "Investigate crimes, gather evidence, perform interrogations, \
    look badass, smoke cigarettes.",
  department: Security,
  alt_titles: ["Detective", "Forensic Technician", "Private Investigator", "Forensic Scientist"],
};

export default Detective;
