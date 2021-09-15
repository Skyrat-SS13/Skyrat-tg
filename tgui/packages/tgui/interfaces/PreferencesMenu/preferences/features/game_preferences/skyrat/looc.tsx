import { CheckboxInput, FeatureToggle } from "../../base";

export const looc_pref: FeatureToggle = {
  name: "See LOOC",
  category: "CHAT",
  description: "Toggles whether you want to see LOOC or not.",
  component: CheckboxInput,
};

export const looc_admin_pref: FeatureToggle = {
  name: "Admin see LOOC",
  category: "CHAT",
  description: "Toggles whether you want to see LOOC anywhere as an admin or not.",
  component: CheckboxInput,
};
