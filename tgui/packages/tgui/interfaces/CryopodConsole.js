import { useBackend } from '../backend';
import { Button, Box, LabeledList, NoticeBox, Section, Stack } from '../components';
import { Window } from '../layouts';

export const CryopodConsole = (props, context) => {
  const { data } = useBackend(context);
  const { account_name } = data;

  const welcomeTitle = `Hello, ${account_name || '[REDACTED]'}!`;
  // Skyrat Edit Addition - Cryostorage stores items.
  // Original does not contain <ItemList /> or its containing Stack.Item
  return (
    <Window title="Cryopod Console" width={400} height={480}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Section title={welcomeTitle}>
              This automated cryogenic freezing unit will safely store your
              corporeal form until your next assignment.
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <CrewList />
          </Stack.Item>
          <Stack.Item grow>
            <ItemList />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
// Skyrat Edit End
};

const CrewList = (props, context) => {
  const { data } = useBackend(context);
  const { frozen_crew } = data;

  return (
    frozen_crew.length && (
      <Section
        fill
        scrollable>
        <LabeledList>
          {frozen_crew.map((person) => (
            <LabeledList.Item key={person} label={person.name}>
              {person.job}
            </LabeledList.Item>
          ))}
        </LabeledList>
      </Section>
    ) || (
      <NoticeBox>No stored crew!</NoticeBox>
    )
  );
};

// Skyrat Edit Addition - Cryostorage stores items.
const ItemList = (props, context) => {
  const { act, data } = useBackend(context);
  const { ref_list, ref_name, ref_allw } = data;
  if (!ref_allw) {
    return (
      <NoticeBox>You are not authorized for item management.</NoticeBox>
    );
  }
  return (
    ref_list.length && (
      <Section fill scrollable>
        <LabeledList>
          {ref_list.map((item) => (
            <LabeledList.Item key={item} label={ref_name[item]}>
              <Button
                icon="exclamation-circle"
                content="Retrieve"
                color="bad"
                onClick={() => act('item_get', { item_get: item })} />
            </LabeledList.Item>
          ))}
        </LabeledList>
      </Section>
    ) || (
      <NoticeBox>No stored items!</NoticeBox>
    )
  );
};
// Skyrat Edit End
