import { Job } from "../base";
import { Assistant as DepartmentAssistant } from "../departments";

const Assistant: Job = {
  name: "Assistant",
  description: "Get your space legs, assist people, ask the HoP to \
    give you a job.",
  department: DepartmentAssistant,
  alt_titles: ["Assistant", "Civilian", "Tourist", "Businessman", "Trader", "Entertainer", "Off-Duty Staff"],
};

export default Assistant;
