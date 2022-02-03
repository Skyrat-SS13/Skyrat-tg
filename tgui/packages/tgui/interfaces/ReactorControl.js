import { useBackend } from '../backend';
import { Section, Stack, Button, LabeledList, NoticeBox, Slider, ProgressBar } from '../components';
import { Window } from '../layouts';

export const ReactorControl = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    reactor_connected,
    exchanger_connected,
    target_control_rod_insertion,
    control_rods = [],
    fuel_rods = [],
  } = data;
  return (
    <Window
      title={'Micron Control Systems Incorporated GA37W EBWR'}
      width={900}
      height={900}>
      <Window.Content>
        {reactor_connected ? (
          <Stack vertical grow>
            <Stack.Item>
              <ReactorStats />
            </Stack.Item>
            <Stack.Item>
              <Section title="Heat Exchanger">
                {exchanger_connected ? (
                  <ExchangerStats />
                ) : (
                  <>
                    <NoticeBox>
                      Heat Exchanger is not connected.
                    </NoticeBox>
                    <Button
                      icon="connect"
                      content="Sync Heatsink"
                      onClick={() => act('sync_heatsink')} />
                  </>
                )}
              </Section>
            </Stack.Item>
            <Stack.Item>
              <Section title="Control Rods"
                buttons={(
                  <Slider
                    value={target_control_rod_insertion}
                    minValue={0}
                    maxValue={100}
                    onChange={(e, value) => act('move_control_rods', {
                      control_rod_insertion: value,
                    })} />
                )}>
                <LabeledList title="Control Rods">
                  {control_rods.map((rod, index) => (
                    <LabeledList.Item
                      key={index}
                      label={rod.name}>
                      <ProgressBar
                        value={rod.insertion_percent}
                        minValue={0}
                        maxValue={100} />
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              </Section>
            </Stack.Item>
          </Stack>
        ) : (
          <>
            <NoticeBox>
              The reactor is not connected.
            </NoticeBox>
            <Button
              icon="plug"
              content="Sync Reactor"
              onClick={() => act('sync_reactor')} />
          </>
        )}
      </Window.Content>
    </Window>
  );
};

export const ReactorStats = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    exchanger_connected,
    reactor_status,
    reactor_temperature,
    reactor_pressure,
    reactor_integrity,
    calculated_power,
    calculated_control_rod_efficiency,
    calculated_cooling_potential,
    ambient_air_temperature,
    reactor_max_temperature,
    reactor_max_pressure,
  } = data;
  return (
    <Stack grow>
      <Stack.Item>
        <Section title={'Reactor Information'}>
          <LabeledList>
            <LabeledList.Item label="Status">
              {reactor_status}
            </LabeledList.Item>
            <LabeledList.Item label="Core Temperature">
              <ProgressBar
                value={reactor_temperature}
                minValue={0}
                maxValue={reactor_max_temperature}
                ranges={{
                  cyan: [0, 200],
                  blue: [200, 300],
                  yellow: [300, 500],
                  average: [500, 800],
                  bad: [800, Infinity],
                }}>
                {reactor_temperature} K
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Core Pressure">
              <ProgressBar
                value={reactor_pressure}
                minValue={0}
                maxValue={reactor_max_pressure}
                ranges={{
                  bad: [reactor_max_pressure * 0.75, Infinity],
                  average: [reactor_max_pressure * 0.5,
                    reactor_max_pressure * 0.75],
                  good: [0, reactor_max_pressure * 0.5],
                }}>
                {reactor_pressure} kPa
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Core Integrity">
              <ProgressBar
                value={reactor_integrity}
                minValue={0}
                maxValue={100}
                ranges={{
                  good: [90, 100],
                  average: [50, 90],
                  bad: [0, 50],
                }}>
                {reactor_integrity} %
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Neutron IP/s">
              <ProgressBar
                value={calculated_power}
                minValue={0}
                maxValue={5}
                ranges={{
                  bad: [4, Infinity],
                  average: [2.5, 4],
                  good: [0, 2.5],
                }}>
                {calculated_power} NIPS
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Control Rod Efficiency">
              <ProgressBar
                value={calculated_control_rod_efficiency}
                minValue={1}
                maxValue={1.5}
                ranges={{
                  good: [1.1, 1.5],
                  average: [1.05, 1.1],
                  bad: [1, 1.05],
                }}>
                {calculated_control_rod_efficiency}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Cooling Potential">
              <ProgressBar
                value={calculated_cooling_potential}
                minValue={0}
                maxValue={1000}
                ranges={{
                  bad: [293, Infinity],
                  average: [220, 293],
                  yellow: [150, 220],
                  blue: [100, 150],
                  cyan: [0, 100],
                }}>
                {calculated_cooling_potential} K
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Ambient Air Temperature">
              <ProgressBar
                value={ambient_air_temperature}
                minValue={0}
                maxValue={1000}
                ranges={{
                  cyan: [0, 200],
                  blue: [200, 300],
                  yellow: [300, 500],
                  average: [500, 800],
                  bad: [800, Infinity],
                }}>
                {ambient_air_temperature} K
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title={'Reactor Controls'}>
          <LabeledList>
            <LabeledList.Item label="AZ-1">
              <Button
                icon="exclamation-triangle"
                color="bad"
                content="FULLY RAISE CONTROL RODS"
                onClick={() => act('turn_on')} />
            </LabeledList.Item>
            <LabeledList.Item label="AZ-2">
              <Button
                icon="temperature-high"
                color="average"
                content="HIGH TEMPERATURE OPERATION"
                onClick={() => act('turn_on')} />
            </LabeledList.Item>
            <LabeledList.Item label="AZ-3">
              <Button
                icon="temperature-low"
                color="yellow"
                content="NOMINAL OPERATION"
                onClick={() => act('turn_on')} />
            </LabeledList.Item>
            <LabeledList.Item label="AZ-4">
              <Button
                icon="atom"
                color="blue"
                content="COLD START"
                onClick={() => act('turn_on')} />
            </LabeledList.Item>
            <LabeledList.Item label="AZ-5">
              <Button
                icon="radiation-alt"
                color="bad"
                content="SCRAM"
                onClick={() => act('turn_on')} />
            </LabeledList.Item>
            <LabeledList.Item label="AZ-6">
              <Button
                icon="cog"
                content="MAINTENANCE MODE"
                onClick={() => act('turn_on')} />
            </LabeledList.Item>
            <LabeledList.Item label="AZ-7">
              <Button
                icon="gas-pump"
                content="FUEL DUMP"
                onClick={() => act('turn_on')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

export const ExchangerStats = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    exchanger_ambient_temperature,
    exchanger_input_gases = [],
    exchanger_input_air_temperature,
    exchanger_input_air_pressure,
    exchanger_output_gases = [],
    exchanger_output_air_temperature,
    exchanger_output_air_pressure,
  } = data;
  return (
    <>
      <LabeledList>
        <LabeledList.Item label="Ambient Temperature">
          {exchanger_ambient_temperature} K
        </LabeledList.Item>
        <LabeledList.Item label="Input Air Temperature">
          {exchanger_input_air_temperature} K
        </LabeledList.Item>
        <LabeledList.Item label="Input Air Pressure">
          {exchanger_input_air_pressure} kPa
        </LabeledList.Item>
        <LabeledList.Item label="Output Air Temperature">
          {exchanger_output_air_temperature} K
        </LabeledList.Item>
        <LabeledList.Item label="Output Air Pressure">
          {exchanger_output_air_pressure} kPa
        </LabeledList.Item>
      </LabeledList>
      <Section title={'Input Gases'}>
        {exchanger_input_gases.length === 0 ? (
          <NoticeBox color="red">
            No input gases detected.
          </NoticeBox>
        ) : (
          <LabeledList>
            {exchanger_input_gases.map(gas => (
              <LabeledList.Item label={gas.name} key={gas.name}>
                <ProgressBar
                  value={gas.amount}
                  minValue={0}
                  maxValue={100}>
                  {gas.amount} %
                </ProgressBar>
              </LabeledList.Item>
            ))}
          </LabeledList>
        )}
      </Section>
      <Section title={'Output Gases'}>
        {exchanger_output_gases.length === 0 ? (
          <NoticeBox color="red">
            No output gases detected.
          </NoticeBox>
        ) : (
          <LabeledList>
            {exchanger_output_gases.map(gas => (
              <LabeledList.Item label={gas.name} key={gas.name}>
                {gas.amount}
              </LabeledList.Item>
            ))}
          </LabeledList>
        )}
      </Section>
    </>
  );
};

