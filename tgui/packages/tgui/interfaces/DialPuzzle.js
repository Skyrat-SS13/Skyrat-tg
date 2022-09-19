import { useBackend } from '../backend';
import { Section, Stack, Knob } from '../components';
import { Window } from '../layouts';

export const DialPuzzle = () => {
  return (
    <Window width={350} height={150} theme="ntos" title="Dial Panel">
      <Window.Content>
        <DialPuzzleContent />
      </Window.Content>
    </Window>
  );
};

export const DialPuzzleContent = (props, context) => {
  const { act, data } = useBackend(context);
  const { current_phrase, dials } = data;

  return (
    <Section title={current_phrase}>
      <Stack>
        <Stack.Item width="270px">
          <Stack>
            {dials.map((dial) => (
              <Stack.Item>
                <Knob
                  size={1.75}
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
              </Stack.Item>
            ))}
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
