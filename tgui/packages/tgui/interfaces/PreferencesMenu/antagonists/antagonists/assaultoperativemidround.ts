import { Antagonist, Category } from "../base";
import { multiline } from "common/string";

export const OPERATIVE_MECHANICAL_DESCRIPTION = multiline`
  Attain all possible GoldenEye authentication keys and use them to activate
  the GoldenEye. These keys use mindfragments of Nanotrasen heads to generate
  the key. Use the interrogator to extract these mindfragments.
`;

const AssaultOperativeMidround: Antagonist = {
  key: "assaultoperativemidround",
  name: "Assault Squad",
  description: [
    multiline`
      A form of assault operative that is offered to ghosts in the middle
      of the shift.
    `,
    OPERATIVE_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default AssaultOperativeMidround;
