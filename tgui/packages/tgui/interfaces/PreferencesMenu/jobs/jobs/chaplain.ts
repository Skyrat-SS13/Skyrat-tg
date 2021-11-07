import { Job } from "../base";
import { Service } from "../departments";

const Chaplain: Job = {
  name: "Chaplain",
  description: "Hold services and funerals, cremate people, preach your \
    religion, protect the crew against cults.",
  department: Service,
  alt_titles: ["Chaplain", "Priest", "Preacher"],
};

export default Chaplain;
