import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Section, Divider, Flex, Box, BlockQuote, Input, LabeledList } from '../components';

export const NifStationPass = (props, context) => {
  const { act, data } = useBackend(context);
  const { name_to_send, text_to_send, messages = [] } = data;
  return (
    <Window width={500} height={700}>
      <Window.Content scrollable>
        <Section title="Messages">
          {messages.map((message) => (
            <Flex.Item key={message.key}>
              <Box textAlign="center" fontSize="14px">
                <b>{message.sender_name}</b>
              </Box>
              <Box>{message.message}</Box>
              <br />
              <BlockQuote>Time Recieved: {message.timestamp}</BlockQuote>
              <Divider />
            </Flex.Item>
          ))}
        </Section>
        <Section title="Settings">
          <LabeledList>
            <LabeledList.Item label={'Display Name'}>
              <Input
                value={name_to_send}
                onInput={(e, value) => act('change_name', { new_name: value })}
                width="100%"
              />
            </LabeledList.Item>
            <LabeledList.Item label={'Message'}>
              <Input
                value={text_to_send}
                onInput={(e, value) =>
                  act('change_message', { new_message: value })
                }
                width="100%"
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
