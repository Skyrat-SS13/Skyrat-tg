import { Job } from "../base";
import { Medical } from "../departments";

const MedicalDoctor: Job = {
  name: "Medical Doctor",
  description: "Save lives, run around the station looking for victims, \
    scan everyone in sight",
  department: Medical,
  alt_titles: ["Medical Doctor", "Surgeon", "Nurse"],
};

export default MedicalDoctor;
