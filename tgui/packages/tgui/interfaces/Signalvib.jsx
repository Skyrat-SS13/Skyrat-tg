// THIS IS A SKYRAT UI FILE
import { toFixed } from 'common/math';

import { useBackend } from '../backend';
import { Button, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

export const Signalvib = (props) => {
  const { act, data } = useBackend();
  const { toystate, code, frequency, minFrequency, maxFrequency } = data;
  return (
    <Window width={260} height={137}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Power">
              <Button
                icon={toystate ? 'power-off' : 'times'}
                content={toystate ? 'On' : 'Off'}
                selected={toystate}
                onClick={() => act('toystate')}
              />
            </LabeledList.Item>
            <LabeledList.Item
              label="Frequency"
              buttons={
                <Button
                  icon="sync"
                  content="Reset"
                  onClick={() =>
                    act('reset', {
                      reset: 'freq',
                    })
                  }
                />
              }
            >
              <NumberInput
                animate
                unit="kHz"
                step={0.2}
                stepPixelSize={6}
                minValue={minFrequency / 10}
                maxValue={maxFrequency / 10}
                value={frequency / 10}
                format={(value) => toFixed(value, 1)}
                width="80px"
                onDrag={(e, value) =>
                  act('freq', {
                    freq: value,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item
              label="Code"
              buttons={
                <Button
                  icon="sync"
                  content="Reset"
                  onClick={() =>
                    act('reset', {
                      reset: 'code',
                    })
                  }
                />
              }
            >
              <NumberInput
                animate
                step={1}
                stepPixelSize={6}
                minValue={1}
                maxValue={100}
                value={code}
                width="80px"
                onDrag={(e, value) =>
                  act('code', {
                    code: value,
                  })
                }
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
