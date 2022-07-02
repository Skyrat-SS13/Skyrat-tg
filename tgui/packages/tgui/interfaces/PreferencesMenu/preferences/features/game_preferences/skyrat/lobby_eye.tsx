import { CheckboxInput, FeatureToggle } from '../../base';

export const lobby_cam_pref: FeatureToggle = {
  name: 'Lobby Eye',
  category: 'GAMEPLAY',
  description: 'Toggles if you want to have the camera that pans pre-game',
  component: CheckboxInput,
};
