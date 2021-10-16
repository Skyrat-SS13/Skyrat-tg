import { Job } from "../base";
import { Service } from "../departments";

const Clown: Job = {
  name: "Clown",
  description: "Entertain the crew, make bad jokes, go on a holy quest to find \
    bananium, HONK!",
  department: Service,
  veteran: true,
  alt_titles: ["Clown", "Jester"],
};

export default Clown;
