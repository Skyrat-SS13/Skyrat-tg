import { useBackend } from '../backend';
import { Icon, Section, Stack } from '../components';
import { Window } from '../layouts';

type Info = {
  antag_name: string;
};

// SKYRAT EDIT change height from 250 to 350
export const AntagInfoClock = (props, context) => {
  const { data } = useBackend<Info>(context);
  const { antag_name } = data;
  return (
    <Window width={620} height={350} theme="clockwork">
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item fontSize="20px" color={'good'}>
              <Icon name={'cog'} rotation={0} spin />
              {' You are the ' + antag_name + '! '}
              <Icon name={'cog'} rotation={35} spin />
            </Stack.Item>
            {/* SKYRAT EDIT ADDITION START */}
            <Stack.Item>
              <Rules />
            </Stack.Item>
            {/* SKYRAT EDIT ADDITION END */}
            <Stack.Item>
              <ObjectivePrintout />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

const ObjectivePrintout = (props, context) => {
  const { data } = useBackend<Info>(context);
  return (
    <Stack vertical>
      <Stack.Item bold>Your goals:</Stack.Item>
      <Stack.Item>
        {
          '- Further the goals of any other organization you are a part of using the power granted to you.'
        }
      </Stack.Item>
      <Stack.Item>
        {
          '- Further the grace, knowledge, and glory of our great lord of the Engine, Ratvar.'
        }
      </Stack.Item>
    </Stack>
  );
};

// SKYRAT EDIT ADDITION START
const Rules = (props, context) => {
  return (
    <Stack vertical>
      <Stack.Item bold>Special Rules:</Stack.Item>
      <Stack.Item>
        {
          '- Do not be surprised if you get arrested for doing clock-work stuff. '
        }
      </Stack.Item>
      <Stack.Item bold>Metaprotections:</Stack.Item>
      <Stack.Item>
        {
          '- The chaplain and curator know everything, including that ratvar himself is out-of-action for the foreseeable future.'
        }
      </Stack.Item>
      <Stack.Item>
        {
          "- Elsewise, your characters can have a baseline knowledge of the cult, that they're as a baseline usually not immediately-aggressive, and that they're more reactive then proactive."
        }
      </Stack.Item>
      <Stack.Item>
        {
          "- Objects used by the cult (cogs, the jud-visor) are all up to common sense; what it looks like it's doing, it's probably doing."
        }
      </Stack.Item>
    </Stack>
  );
};
// SKYRAT EDIT ADDITION END
