import { Button, Stack } from '../../../../../../components';
import { Feature, FeatureValueProps } from '../../base';

export const dc_config: Feature<undefined, undefined> = {
  name: 'Open DC config',
  component: (props: FeatureValueProps<undefined, undefined>) => {
    const { act } = props;

    return (
      <Stack>
        <Stack.Item>
          <Button
            content="Open"
            onClick={() => act('open_death_consequences_config')}
          />
        </Stack.Item>
      </Stack>
    );
  },
};
