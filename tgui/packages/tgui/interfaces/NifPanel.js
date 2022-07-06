import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';
import { Box, Dropdown, LabeledList, ProgressBar, Section, Button, Input } from '../components';

export const NifPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { linked_mob_name } = data;
  const [settingsOpen, setSettingsOpen] = useLocalState(
    context,
    settingsOpen,
    false
  );

  return (
    <Window
      title={'Nanite Implant Framework'}
      width={500}
      height={400}
      resizable>
      <Window.Content>
        <Section
          title={'Welcome to your NIF, ' + linked_mob_name}
          buttons={
            <Button
              icon="cogs"
              tooltip="NIF Settings"
              tooltiptooltipPosition="bottom-end"
              selected={settingsOpen}
              onClick={() => setSettingsOpen(!settingsOpen)}
            />
          }>
          {(settingsOpen && <NifSettings />) || <NifStats />}
          {!settingsOpen && (
            <Section title={'NIFSoft Programs'}>
              <NifPrograms />
            </Section>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};

const NifSettings = (props, context) => {
  const { act, data } = useBackend(context);
  const { theme, product_notes, nutrition_unavalible, nutrition_drain } = data;
  return (
    <LabeledList>
      <LabeledList.Item label="NIF Theme">
        <Dropdown width="100%" />
      </LabeledList.Item>
      <LabeledList.Item label="Examine Text">
        <Input onInput={(e, value) => act('change_examine_text', { new_text : value })} width="100%" />
      </LabeledList.Item>
      <LabeledList.Item label="Nutrition Drain">
        <Button fluid
        content={(nutrition_drain === 0) ? "Nutrition Drain Disabled" : "Nutrition Drain enabled"}
        tooltip="Toggles the ability for the NIF to use your food as an energy source. Enabling this may result in increased hunger."
        onClick={() => act('toggle_nutrition_drain')}
        disabled={nutrition_unavalible} />
      </LabeledList.Item>
    </LabeledList>
  );
};

const NifStats = (props, context) => {
  const { act, data } = useBackend(context);
  const { max_power, power_level, durability, nutrition_level, nutrition_drain } = data;

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
        {(nutrition_drain === 1) && (
          <LabeledList.Item label="User Nutrition">
            <NifNutritionBar />
          </LabeledList.Item>
        )}
      </LabeledList>
    </Box>
  );
};

const NifNutritionBar = (props, context) => {
  const { act, data } = useBackend(context);
  const { nutrition_level } = data;
  return (
    <ProgressBar
      value={nutrition_level}
      minValue={0}
      maxValue={550}
      ranges={{
        'good' : [250, Infinity],
        'average' : [150, 250],
        'bad' : [0, 150],
      }} />
  );
};

const NifPrograms = (props, context) => {
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
