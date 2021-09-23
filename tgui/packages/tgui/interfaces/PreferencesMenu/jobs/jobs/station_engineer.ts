import { Job } from "../base";
import { Engineering } from "../departments";

const StationEngineer: Job = {
  name: "Station Engineer",
  description: "Start the Supermatter, wire the solars, repair station hull \
    and wiring damage.",
  department: Engineering,
  alt_titles: ["Station Engineer", "Emergency Damage Control Technician", "Electrician", "Engine Technician", "EVA Technician"],
};

export default StationEngineer;
