import { Job } from "../base";
import { Medical } from "../departments";

const Nurse: Job = {
  name: "Nurse",
  description: "Wear frilly dresses, fetch the MD a IV drip, STAT. \
    Observe Surgery and take notes.",
  department: Medical,
  alt_titles: ["Medical Resident", "Medical Assistant"],
};

export default Nurse;
