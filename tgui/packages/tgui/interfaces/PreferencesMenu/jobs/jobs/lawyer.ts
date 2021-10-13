import { Job } from "../base";
import { Security } from "../departments";

const Lawyer: Job = {
  name: "Lawyer",
  description: "Advocate for prisoners, create law-binding contracts, \
    ensure Security is following protocol and Space Law.",
  department: Security,
  alt_titles: ["Lawyer", "Internal Affairs Agent", "Human Resources Agent"],
};

export default Lawyer;
