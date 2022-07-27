import { useBackend } from '../backend';
import { LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const CorvetteConsole = (props, context) => {
  const { data } = useBackend(context);
  return (
    <Window
      theme='ntos'
      title='Corvette Console'
      width={500}
      height={500}
      >
        <Window.Content scrollable>
          <Section
            title='Jumps To Destination'
            >
            <LabeledList>
              <LabeledList.Item
              label='Jumps:'
              >
                {data.jumpsleft}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Window.Content>
    </Window>
  );
};
