import { FeatureColorInput, FeatureToggle, Feature, CheckboxInput } from "../../base";

export const enable_chat_color_player: FeatureToggle = {
  name: "Runechat color",
  component: CheckboxInput,
};

export const chat_color_player: Feature<string> = {
  name: "Runechat color",
  component: FeatureColorInput,
};
