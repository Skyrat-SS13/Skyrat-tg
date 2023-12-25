// THIS IS A SKYRAT UI FILE
import { multiline } from 'common/string';

import { CheckboxInput, FeatureToggle } from '../../base';

export const face_cursor_combat_mode: FeatureToggle = {
  name: 'Face cursor with combat mode',
  category: 'GAMEPLAY',
  description: multiline`
    When toggled, you will now face towards the cursor
    with combat mode enabled.
  `,
  component: CheckboxInput,
};
