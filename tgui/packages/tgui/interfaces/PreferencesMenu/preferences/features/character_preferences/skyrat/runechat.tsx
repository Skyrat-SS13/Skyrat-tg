import { FeatureColorInput, FeatureToggle, Feature, CheckboxInput } from "../../base";

export const enable_chat_color_player: FeatureToggle = {
  name: "Custom Runechat color",
  component: CheckboxInput,
};

export const chat_color_player: Feature<string> = {
  name: "Custom Runechat color",
  component: FeatureColorInput,
};
