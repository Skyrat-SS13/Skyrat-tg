import { useBackend } from '../backend';
import { Section, Stack } from '../components';
import { Window } from '../layouts';

type Info = {
  name: string;
  info: string;
};

export const StoryParticipant = (props, context) => {
  const { data } = useBackend<Info>(context);
  const { name } = data;
  return (
    <Window width={620} height={250}>
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item textColor="red" fontSize="20px">
              You are the {name}!
            </Stack.Item>
            <Stack.Item>
              <InfoPrintout />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

const InfoPrintout = (props, context) => {
  const { data } = useBackend<Info>(context);
  const { info } = data;
  return (
    <Stack vertical>
      <Stack.Item bold>Your backstory:</Stack.Item>
      <Stack.Item>{info}</Stack.Item>
    </Stack>
  );
};
