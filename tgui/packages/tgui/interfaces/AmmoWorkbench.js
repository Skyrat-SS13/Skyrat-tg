import { toTitleCase } from 'common/string';
import { useBackend, useSharedState, useLocalState } from '../backend';
import { Box, Button, NumberInput, NoticeBox, ProgressBar, Section, Flex, Stack, RoundGauge, Tabs, Table } from '../components';
import { Window } from '../layouts';

export const AmmoWorkbench = (props, context) => {
  const [tab, setTab] = useSharedState(context, 'tab', 1);
  return (
    <Window
      width={600}
      height={480}
      theme="hackerman">
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab
            selected={tab === 1}
            onClick={() => setTab(1)}>
            Ammunitions
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 2}
            onClick={() => setTab(2)}>
            Materials
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && (
          <AmmunitionsTab />
        )}
        {tab === 2 && (
          <MaterialsTab />
        )}
      </Window.Content>
    </Window>
  );
};

export const AmmunitionsTab = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    mag_loaded,
    system_busy,
    error,
    mag_name,
    caliber,
    current_rounds,
    max_rounds,
    efficiency,
    time,
    available_rounds = [],
  } = data;
  return (
    <>
      {!!error && (
        <NoticeBox textAlign="center">
          {error}
        </NoticeBox>
      )}
      <Box inline mr={4}>
        Current Efficiency: <RoundGauge
          value={efficiency}
          minValue={1.6}
          maxValue={1}
          format={() => null}
        />
        Time Per Round: {time} seconds
      </Box>
      <Section
        title="Loaded Magazine"
        buttons={(
          <>
            {!!mag_loaded && (
              <Box inline mr={2}>
                <ProgressBar
                  value={current_rounds}
                  minValue={0}
                  maxValue={max_rounds}
                />
              </Box>
            )}
            <Button
              icon="eject"
              content="Eject"
              disabled={!mag_loaded}
              onClick={() => act('EjectMag')} />
          </>
        )}>
        {!!mag_loaded && (
          <Box mt="3px" mb="5px">
            {toTitleCase(mag_name)}
          </Box>
        )}
        {!!mag_loaded && (
          <Box
            bold
            textAlign="right">
            {current_rounds} / {max_rounds}
          </Box>
        )}
      </Section>
      <Section title="Available Ammunition Types">
        {!!mag_loaded && (
          <Flex.Item grow={1} basis={0}>
            {available_rounds.map(available_round => (
              <Box
                key={available_round.name}
                className="candystripe"
                p={1}
                pb={2}>
                <Stack.Item>
                  <Button
                    content={available_round.name}
                    disabled={current_rounds === max_rounds}
                    onClick={() => act('FillMagazine', {
                      selected_type: available_round.typepath,
                    })} />
                </Stack.Item>
              </Box>
            ))}
          </Flex.Item>
        )}
      </Section>
    </>
  );
};

export const MaterialsTab = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    materials = [],
  } = data;
  return (
    <Section title="Materials">
      <Table>
        {materials.map(material => (
          <MaterialRow
            key={material.id}
            material={material}
            onRelease={amount => act('Release', {
              id: material.id,
              sheets: amount,
            })} />
        ))}
      </Table>
    </Section>
  );
};

const MaterialRow = (props, context) => {
  const { material, onRelease } = props;

  const [
    amount,
    setAmount,
  ] = useLocalState(context, "amount" + material.name, 1);

  const amountAvailable = Math.floor(material.amount);
  return (
    <Table.Row>
      <Table.Cell>
        {toTitleCase(material.name).replace('Alloy', '')}
      </Table.Cell>
      <Table.Cell collapsing textAlign="right">
        <Box mr={2} color="label" inline>
          {material.value && material.value + ' cr'}
        </Box>
      </Table.Cell>
      <Table.Cell collapsing textAlign="right">
        <Box mr={2} color="label" inline>
          {amountAvailable} sheets
        </Box>
      </Table.Cell>
      <Table.Cell collapsing>
        <NumberInput
          width="32px"
          step={1}
          stepPixelSize={5}
          minValue={1}
          maxValue={50}
          value={amount}
          onChange={(e, value) => setAmount(value)} />
        <Button
          disabled={amountAvailable < 1}
          content="Release"
          onClick={() => onRelease(amount)} />
      </Table.Cell>
    </Table.Row>
  );
};
