import { Job } from "../base";
import { Service } from "../departments";

const HeadOfPersonnel: Job = {
  name: "Head of Personnel",
  description: "Alter access on ID cards, manage civil and supply departments, \
    protect Ian, run the station when the captain dies.",
  department: Service,
  alt_titles: ["Head of Personnel", "Executive Officer", "Employment Officer", "Crew Supervisor"],
};

export default HeadOfPersonnel;
