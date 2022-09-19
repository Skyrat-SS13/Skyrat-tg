import { useBackend } from '../backend';
import { LabeledList, Section, ProgressBar } from '../components';
import { Window } from '../layouts';

export const CorvetteConsole = (props, context) => {
  const { data } = useBackend(context);
  return (
    <Window theme="ntos" title="Corvette Console" width={500} height={500}>
      <Window.Content>
        <Section title="Jumps To Destination">
          <LabeledList>
            <LabeledList.Item label="Jumps">{data.jumpsleft}</LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="System Status">
          <LabeledList>
            {data.systems.map((system) => (
              <LabeledList.Item key={system} label={system.name}>
                <ProgressBar
                  value={system.health}
                  ranges={{
                    good: [0.8, Infinity],
                    average: [0.5, 0.8],
                    bad: [-Infinity, 0.5],
                  }}
                />
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
