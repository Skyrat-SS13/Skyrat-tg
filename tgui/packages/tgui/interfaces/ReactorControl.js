import { useBackend } from '../backend';
import { Section, Stack, Button, LabeledList } from '../components';
import { Window } from '../layouts';

export const ReactorControl = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    reactor_status,
    reactor_temperature,
    reactor_pressure,
    reactor_integrity,
    calculated_power,
    calculated_control_rod_efficiency,
    calculated_cooling_potential,
  } = data;
  return (
    <Window
      title={'Micron Control Systems Incorporated GA37W EBWR'}
      width={500}
      height={700}>
      <Window.Content>
        <Stack vertical grow>
          <Stack.Item>
            <Section
              title={'Reactor Information'}
              buttons={(
                <Button
                  icon="power-on"
                  content={reactor_status}
                  selected={reactor_status === 'Online'}
                  onClick={() => act('turn_on')} />
              )}>
              <LabeledList>
                <LabeledList.Item label="Status">
                  {reactor_status}
                </LabeledList.Item>
                <LabeledList.Item label="Core Temperature">
                  {reactor_temperature} K
                </LabeledList.Item>
                <LabeledList.Item label="Core Pressure">
                  {reactor_pressure} kPa
                </LabeledList.Item>
                <LabeledList.Item label="Core Integrity">
                  {reactor_integrity} %
                </LabeledList.Item>
                <LabeledList.Item label="Calculated Power">
                  {calculated_power}
                </LabeledList.Item>
                <LabeledList.Item label="Calculated Control Rod Efficiency">
                  {calculated_control_rod_efficiency}%
                </LabeledList.Item>
                <LabeledList.Item label="Calculated Cooling Potential">
                  {calculated_cooling_potential}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
