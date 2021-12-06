import { multiline } from "common/string";
import { CheckboxInput, FeatureToggle } from "../../base";

export const combat_mode_sticky_directions: FeatureToggle = {
  name: "Enable Combat Mode Sticky Directions",
  category: "GAMEPLAY",
  description: multiline`
    When toggled, your movements will no longer turn your character after facing something for a moment.
  `,
  component: CheckboxInput,
};
