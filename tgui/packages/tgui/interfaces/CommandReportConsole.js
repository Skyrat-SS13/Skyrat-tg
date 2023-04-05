import { useBackend } from '../backend';
import { Button, NoticeBox, Input, Section, Stack, TextArea } from '../components';
import { Window } from '../layouts';

export const CommandReportConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    command_report_content,
    command_report_title,
    announce_contents,
    error,
  } = data;
  return (
    <Window title="Create Fleet Report" width={325} height={525}>
      <Window.Content>
        {!!error && (
          <NoticeBox textAlign="center" color="red">
            {error}
          </NoticeBox>
        )}
        <Stack vertical>
          <Stack.Item>
            <Section title="Set report title:" textAlign="center">
              <Input
                width="100%"
                mt={1}
                value={command_report_title}
                onChange={(e, value) =>
                  act('update_report_title', {
                    updated_title: value,
                  })
                }
              />
            </Section>
            <Section title="Set report text:" textAlign="center">
              <TextArea
                height="200px"
                mb={1}
                value={command_report_content}
                onChange={(e, value) =>
                  act('update_report_contents', {
                    updated_contents: value,
                  })
                }
              />
              <Stack vertical>
                <Stack.Item>
                  <Button.Checkbox
                    fluid
                    checked={announce_contents}
                    onClick={() => act('toggle_announce')}>
                    Announce Contents
                  </Button.Checkbox>
                </Stack.Item>
                <Stack.Item>
                  <Button.Confirm
                    fluid
                    icon="check"
                    color="good"
                    textAlign="center"
                    content="Submit Report"
                    onClick={() => act('submit_report')}
                  />
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
