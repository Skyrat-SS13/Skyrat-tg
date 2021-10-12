import { Job } from "../base";
import { Service } from "../departments";

const Barber: Job = {
  name: "Barber",
  description: "Run your salon and meet the crews sanitary needs, such as hair cutting, massaging and more!",
  department: Service,
  alt_titles: ["Salon Manager", "Salon Technician", "Stylist", "Colorist"],
};

export default Barber;
