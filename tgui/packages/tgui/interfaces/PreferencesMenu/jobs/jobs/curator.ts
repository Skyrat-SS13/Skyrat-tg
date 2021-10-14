import { Job } from "../base";
import { Service } from "../departments";

const Curator: Job = {
  name: "Curator",
  description: "Read and write books and hand them to people, stock \
    bookshelves, report on station news.",
  department: Service,
  alt_titles: ["Curator", "Librarian", "Journalist", "Archivist"],
};

export default Curator;
