import { Job } from "../base";
import { Security } from "../departments";

const SecurityMedic: Job = {
  name: "Security Medic",
  description: "Patch up officers and prisoners, realize you don't have the tools to Tend Wounds, barge into Medbay and tell them how to do their jobs",
  department: Security,
  alt_titles: ["Security Medic", "Field Medic", "Security Corpsman", "Brig Physician"],
};

export default SecurityMedic;
