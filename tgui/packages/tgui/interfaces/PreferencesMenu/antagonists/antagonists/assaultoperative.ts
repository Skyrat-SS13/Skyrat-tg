import { Antagonist, Category } from "../base";
import { multiline } from "common/string";

export const OPERATIVE_MECHANICAL_DESCRIPTION = multiline`
  Attain all possible GoldenEye authentication keys and use them to activate
  the GoldenEye. These keys use mindfragments of Nanotrasen heads to generate
  the key. Use the interrogator to extract these mindfragments.
`;

const AssaultOperative: Antagonist = {
  key: "assaultoperative",
  name: "Assault Operative",
  description: [
    multiline`
      Good afternoon 0013, you have been selected to join an elite strike team
      designated to locating and forging GoldenEye keys. Your mission, whether
      or not you choose to accept it, is to get these keys and use them to
      destroy Nanotrasen's GoldenEye Defence Network.
    `,

    OPERATIVE_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default AssaultOperative;
