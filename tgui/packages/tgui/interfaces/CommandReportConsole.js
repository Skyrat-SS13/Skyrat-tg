import { useBackend } from '../backend';
import { Button, Dropdown, Input, Section, Stack, TextArea } from '../components';
import { Window } from '../layouts';

export const CommandReportConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    command_report_content,
    announce_contents,
  } = data;
  return (
    <Window
      title="Create Fleet Report"
      width={325}
      height={525}>
      <Window.Content>
        <Stack vertical>
          <Stack.Item>
            <Section title="Set report text:" textAlign="center">
              <TextArea
                height="200px"
                mb={1}
                value={command_report_content}
                onChange={(e, value) => act("update_report_contents", {
                  updated_contents: value,
                })} />
              <Stack vertical>
                <Stack.Item>
                  <Button.Checkbox
                    fluid
                    checked={announce_contents}
                    onClick={() => act("toggle_announce")}>
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
                    onClick={() => act("submit_report")} />
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
