// THIS IS A SKYRAT UI FILE
import { CheckboxInput, FeatureToggle } from '../../base';

export const do_emote_overlay: FeatureToggle = {
  name: 'Show/Hide my emote effect overlays',
  category: 'CHAT',
  description:
    'This shows/hides the animated overlays displayed on emotes for yourself.',
  component: CheckboxInput,
};
