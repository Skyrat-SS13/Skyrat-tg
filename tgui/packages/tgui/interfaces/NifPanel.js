import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Box, Dropdown, LabeledList, ProgressBar, Section } from '../components';

export const NifPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { linked_mob_name } = data;
  return (
    <Window
      title={'Nanite Implant Frameworkk'}
      width={500}
      height={400}
      resizable>
      <Window.Content>
        <Section title={'Welcome to your NIF, ' + linked_mob_name}>
          <NifStats />
        </Section>
      </Window.Content>
    </Window>
  );
};

const NifSettings = (props, context) => {
  const { act, data } = useBackend(context);
  const { theme, product_notes } = data;
  return (
    <LabeledList>
      <LabeledList.Item label="NIF Theme">
        <Dropdown />
      </LabeledList.Item>
    </LabeledList>
  );
};

const NifStats = (props, context) => {
  const { act, data } = useBackend(context);
  const { max_power, power_level, durability } = data;
  return (
    <Box>
      <LabeledList>
        <LabeledList.Item label="NIF Condition">
          <ProgressBar
            value={durability}
            minValue={0}
            maxValue={100}
            ranges={{
              'good': [66, 100],
              'average': [33, 66],
              'bad': [0, 33],
            }}
            alertAfter={25}
          />
        </LabeledList.Item>
        <LabeledList.Item label="NIF Power">
          <ProgressBar
            value={power_level}
            minValue={0}
            maxValue={max_power}
            ranges={{
              'good': [max_power * 0.66, max_power],
              'average': [max_power * 0.33, max_power * 0.66],
              'bad': [0, max_power * 0.33],
            }}
            alertAfter={max_power * 0.1}
          />
        </LabeledList.Item>
      </LabeledList>
    </Box>
  );
};
