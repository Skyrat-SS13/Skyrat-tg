import { Job } from "../base";
import { Security } from "../departments";

const SecurityOfficer: Job = {
  name: "Security Officer",
  description: "Protect company assets, follow the Standard Operating \
    Procedure, eat donuts",
  department: Security,
  alt_titles: ["Security Officer", "Security Operative", "Peacekeeper"],
};

export default SecurityOfficer;
