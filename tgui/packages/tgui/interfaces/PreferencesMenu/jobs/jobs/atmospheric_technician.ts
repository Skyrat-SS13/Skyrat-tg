import { Job } from "../base";
import { Engineering } from "../departments";

const AtmosphericTechnician: Job = {
  name: "Atmospheric Technician",
  description: "Ensure the air is breathable on the station, fill oxygen \
    tanks, fight fires, purify the air.",
  department: Engineering,
  alt_titles: ["Atmospheric Technician", "Life Support Technician", "Emergency Fire Technician"],
};

export default AtmosphericTechnician;
