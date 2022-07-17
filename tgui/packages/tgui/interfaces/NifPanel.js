import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';
import { Box, Dropdown, LabeledList, ProgressBar, Section, Button, Input, BlockQuote, Flex, Collapsible, Table } from '../components';
import { TableCell, TableRow } from '../components/Table';

export const NifPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { linked_mob_name, loaded_nifsofts, max_nifsofts, power_level, current_theme } = data;
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
      resizable
      theme={current_theme}>
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
          {(!settingsOpen &&
            <Section title={'NIFSoft Programs (' + (max_nifsofts - loaded_nifsofts.length) + " Slots Remaining)"} right>
              {(loaded_nifsofts.length &&
              <Flex direction="column">
                {loaded_nifsofts.map((nifsoft) => (
                  <Flex.Item key={nifsoft.name}>
                    <Collapsible title={nifsoft.name} buttons={
                      <Button icon="play" color="green" />}>
                      <Table>
                        <TableRow>
                          <TableCell>
                            <Button icon="bolt" color="yellow" tooltip="What percent of the power is used when activating the NIFSoft" />
                            {(nifsoft.activation_cost === 0) ? (" No activation cost") : (" " + ((nifsoft.activation_cost / power_level) * 100) + "% per activation")}
                          </TableCell>
                          <TableCell>
                            <Button icon="battery-half" color="orange" tooltip="The power that the NIFSoft uses while active" disabled={nifsoft.active_cost === 0} />
                            {(nifsoft.active_cost === 0) ? " No active drain" : (" " + nifsoft.active_cost)}
                          </TableCell>
                          <TableCell>
                            <Button icon="exclamation" color={nifsoft.active ? "green" : "red"}
                            tooltip="Shows whether or not a program is currently active or not" />
                            {nifsoft.active ? " The NIFSoft is active!" : " The NIFSoft is inactive!"}
                          </TableCell>
                        </TableRow>
                      </Table>
                      <br />
                      <BlockQuote>
                        {nifsoft.desc}
                      </BlockQuote>
                      <box>
                        <br />
                        <Button icon="cogs" content="Configure" color="blue" fluid tooltip="Configure the options on the current NIFSoft" />
                        <Button.Confirm icon="trash" content="Uninstall" color="red" fluid tooltip="Uninstall the selected NIFSoft" confirmContent="Are you sure?" confirmIcon="question"
                        onClick={() => act('uninstall_nifsoft', { nifsoft_to_remove : nifsoft.reference })} />
                      </box>
                    </Collapsible>
                  </Flex.Item>
                ))}
              </Flex>
              ) || (<Box> <center><b>There are no NIFSofts currently installed</b></center> </Box>)}
            </Section>
          ) || (<Section title={"Product Info"}>
                <NifProductNotes />
                </Section>)}
        </Section>
      </Window.Content>
    </Window>
  );
};

const NifSettings = (props, context) => {
  const { act, data } = useBackend(context);
  const { nutrition_unavalible, nutrition_drain, ui_themes, current_theme } = data;
  return (
    <LabeledList>
      <LabeledList.Item label="NIF Theme">
        <Dropdown width="100%" selected={current_theme} options={ui_themes}
        onSelected={(value) => act("change_theme", { target_theme : value })} />
      </LabeledList.Item>
      <LabeledList.Item label="Examine Text">
        <Input onInput={(e, value) => act('change_examine_text', { new_text : value })} width="100%" />
      </LabeledList.Item>
      <LabeledList.Item label="Nutrition Drain">
        <Button fluid
        content={(nutrition_drain === 0) ? "Nutrition Drain Disabled" : "Nutrition Drain Enabled"}
        tooltip="Toggles the ability for the NIF to use your food as an energy source. Enabling this may result in increased hunger."
        onClick={() => act('toggle_nutrition_drain')}
        disabled={nutrition_unavalible} />
      </LabeledList.Item>
    </LabeledList>
  );
};

const NifProductNotes = (props, context) => {
  const { act, data } = useBackend(context);
  const { product_notes } = data;
  return (
    <BlockQuote>
      {product_notes}
    </BlockQuote>
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

