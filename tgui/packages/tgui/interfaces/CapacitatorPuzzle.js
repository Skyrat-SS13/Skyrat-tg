import { useBackend } from '../backend';
import { Button, LabeledList, ProgressBar, Section, Stack } from '../components';
import { Window } from '../layouts';

export const CapacitatorPuzzle = () => {
  return (
    <Window width={350} height={175} theme="ntos" title="Capacitator Panel">
      <Window.Content scrollable>
        <CapacitatorPuzzleContent />
      </Window.Content>
    </Window>
  );
};

export const CapacitatorPuzzleContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    capacitator_charge,
  } = data;

  return (
    <Section
      title={"Main Capacitator"}
      buttons={
        <Button
          icon="bolt"
          content="Clear Charge"
          onClick={() => act('capacitator_clear')}
        />
      }>
      <Stack>
        <Stack.Item width="270px">
          <Section title="Metrics">
            <LabeledList>
              <LabeledList.Item label="Charge">
                <ProgressBar
                  value={capacitator_charge / 100}
                  ranges={{
                    good: [-Infinity, 0.5],
                    average: [0.5, 0.8],
                    bad: [0.8, Infinity],
                  }}
                />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
