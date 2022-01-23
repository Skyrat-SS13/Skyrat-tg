import { CheckboxInput, FeatureNumberInput, FeatureNumeric, FeatureToggle, FeatureColorInput, Feature } from "../base"; // Skyrat add "FeatureColorInput, Feature"

export const chat_color_player: Feature<string> = { // Skyrat add
  name: "Runechat color",
  category: "RUNECHAT",
  description: "The color of your runechat speechbubbles. '#000000' returns name generated colors.",
  component: FeatureColorInput,
}; //

export const chat_on_map: FeatureToggle = {
  name: "Enable Runechat",
  category: "RUNECHAT",
  description: "Chat messages will show above heads.",
  component: CheckboxInput,
};

export const see_chat_non_mob: FeatureToggle = {
  name: "Enable Runechat on objects",
  category: "RUNECHAT",
  description: "Chat messages will show above objects when they speak.",
  component: CheckboxInput,
};

export const see_rc_emotes: FeatureToggle = {
  name: "Enable Runechat emotes",
  category: "RUNECHAT",
  description: "Emotes will show above heads.",
  component: CheckboxInput,
};

export const max_chat_length: FeatureNumeric = {
  name: "Max chat length",
  category: "RUNECHAT",
  description: "The maximum length a Runechat message will show as.",
  component: FeatureNumberInput,
};
