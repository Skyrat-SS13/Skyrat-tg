import { useBackend } from '../backend';
import { Button, LabeledList, ProgressBar, Section, Stack, Knob } from '../components';
import { Window } from '../layouts';

export const DialPuzzle = () => {
  return (
    <Window width={350} height={300} theme="ntos" title="Dial Panel">
      <Window.Content scrollable>
        <DialPuzzleContent />
      </Window.Content>
    </Window>
  );
};

export const DialPuzzleContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    current_phrase,
    dials,
  } = data;

  return (
    <Section
      title={"Dial Panel"}>
      <Stack>
        <Stack.Item width="270px">
          <Section title="Metrics">
            {current_phrase}
            <LabeledList>
              {dials.map((dial) => (
                <LabeledList.Item label="Dial">
                  <Knob
                    size={1.5}
                    value={dial.dial_value}
                    unit=""
                    minValue={0}
                    maxValue={100}
                    step={1}
                    stepPixelSize={1}
                    onDrag={(e, value) =>
                      act('dial_adjust', {
                        dial_val: value,
                        dial_number: dial.dial_num,
                      })
                    }
                  />
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
