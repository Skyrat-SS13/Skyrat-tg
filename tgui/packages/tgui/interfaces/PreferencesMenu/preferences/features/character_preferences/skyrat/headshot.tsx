import { Feature, FeatureShortTextInput } from '../../base';

export const headshot: Feature<string> = {
  name: 'Headshot',
  description:
    'Requires a link ending with .png, .jpeg, or .jpg, starting with \
    https://, and hosted on Gyazo or Discord. Renders the image underneath \
    your character preview in the examine more window.',
  component: FeatureShortTextInput,
};
