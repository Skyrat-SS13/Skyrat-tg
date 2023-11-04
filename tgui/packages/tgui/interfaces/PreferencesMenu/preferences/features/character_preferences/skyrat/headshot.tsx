import { Feature, FeatureShortTextInput } from '../../base';

export const headshot: Feature<string> = {
  name: 'Headshot',
  description:
    'Requires a link ending with .png, .jpeg, or .jpg, and starting with \
    https://. Renders the image underneath your character preview in the \
    examine more window.',
  component: FeatureShortTextInput,
};
