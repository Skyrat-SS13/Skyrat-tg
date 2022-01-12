import { CheckboxInput, FeatureToggle } from "../../base";

export const see_emote_overlay: FeatureToggle = {
  name: "Show/Hide emote effect overlays",
  category: "CHAT",
  description: "This shows/hides the animated overlays displayed on emotes.",
  component: CheckboxInput,
};
