// THIS IS A SKYRAT UI FILE
import { BooleanLike } from 'common/react';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Slider,
} from '../components';
import { formatPower } from '../format';
import { Window } from '../layouts';

type Data = {
  connected: BooleanLike;
  notice: string;
  unlocked: BooleanLike;
  target: string;
  powernet_power: number;
  capacitor_charge: number;
  target_capacitor_charge: number;
  max_capacitor_charge: number;
  status: string;
};

export const BluespaceArtillerySkyrat = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    notice,
    connected,
    unlocked,
    target,
    powernet_power,
    capacitor_charge,
    target_capacitor_charge,
    max_capacitor_charge,
    status,
  } = data;

  return (
    <Window width={600} height={600}>
      <Window.Content>
        {!!notice && <NoticeBox>{notice}</NoticeBox>}
        {connected ? (
          <>
            <Section title="System Status">
              <Box
                color={status !== 'SYSTEM READY' ? 'bad' : 'green'}
                fontSize="25px"
              >
                {status}
              </Box>
            </Section>
            <Section
              title="Capacitors"
              buttons={
                <Button
                  content="Charge Capacitors"
                  color="orange"
                  onClick={() => act('charge')}
                />
              }
            >
              <LabeledList>
                <LabeledList.Item label="Capacitor Charge">
                  {formatPower(capacitor_charge, 1)}
                </LabeledList.Item>
                <LabeledList.Item label="Available Power">
                  {formatPower(powernet_power, 1)}
                </LabeledList.Item>
                <LabeledList.Item label="Target Charge">
                  <Slider
                    value={target_capacitor_charge}
                    fillValue={target_capacitor_charge}
                    minValue={0}
                    maxValue={max_capacitor_charge}
                    step={100000}
                    stepPixelSize={1}
                    format={(value) => formatPower(value, 1)}
                    onDrag={(e, value) =>
                      act('capacitor_target_change', {
                        capacitor_target: value,
                      })
                    }
                  />
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Section
              title="Target"
              buttons={
                <Button
                  icon="crosshairs"
                  disabled={!unlocked}
                  onClick={() => act('recalibrate')}
                />
              }
            >
              <Box color={target ? 'average' : 'bad'} fontSize="25px">
                {target || 'No Target Set'}
              </Box>
            </Section>
            <Section>
              {unlocked ? (
                <Box style={{ margin: 'auto' }}>
                  <Button
                    fluid
                    content="FIRE"
                    color="bad"
                    disabled={!target || status !== 'SYSTEM READY'}
                    fontSize="30px"
                    textAlign="center"
                    lineHeight="46px"
                    onClick={() => act('fire')}
                  />
                </Box>
              ) : (
                <>
                  <Box color="bad" fontSize="18px">
                    Bluespace artillery is currently locked.
                  </Box>
                  <Box mt={1}>
                    Awaiting authorization via keycard reader from at minimum
                    two station heads.
                  </Box>
                </>
              )}
            </Section>
          </>
        ) : (
          <Section>
            <LabeledList>
              <LabeledList.Item label="Maintenance">
                <Button
                  icon="wrench"
                  content="Complete Deployment"
                  onClick={() => act('build')}
                />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
