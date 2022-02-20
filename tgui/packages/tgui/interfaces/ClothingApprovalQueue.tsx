import { useBackend } from '../backend';
import { Stack, Button, ByondUi, Divider } from '../components';
import { Window } from '../layouts';

type ApprovalQueue = {
  pattern_data: PatternData;
  assigned_map: string;
}

type PatternData = {
  name: string;
  desc: string;
  ckey_author: string;
  author: string;
  id: number;
  slot: string;
  digitigrade: boolean;
};

export const ClothingApprovalQueue = (props, context) => {
  const { act, data } = useBackend<ApprovalQueue>(context);
  return (
    <Window
      title="Clothing Approval Queue"
      width={400}
      height={670}>
      <Window.Content>
        <Stack vertical>
          <Stack.Item>
            <ByondUi
              height="220px"
              width="220px"
              className="ApprovalQueue__ByondUi"
              params={{
                id: data.assigned_map,
                type: 'map',
              }} />
          </Stack.Item>
          <Stack.Item grow>
            <Button
              onClick={() => {
                act('rotate');
              }}
              icon="undo"
            />
          </Stack.Item>
          <Stack.Item>
            <Divider />
          </Stack.Item>
          <Stack.Item>
            Name: {data.pattern_data.name}
          </Stack.Item>
          <Stack.Item>
            Description:
          </Stack.Item>
          <Stack.Item>
            {data.pattern_data.desc}
          </Stack.Item>
          <Stack.Item>
            Author: {data.pattern_data.author}
          </Stack.Item>
          <Stack.Item>
            Uploader: {data.pattern_data.ckey_author}
          </Stack.Item>
          <Stack.Item>
            <Divider />
          </Stack.Item>
          <Stack.Item>
            <Stack>
              <Stack.Item grow>
                <Button
                  fluid
                  onClick={() => {
                    act('approve_pattern');
                  }}
                  color="good"
                  icon="check"
                >
                  Approve Pattern
                </Button>
              </Stack.Item>
              <Stack.Item grow>
                <Button
                  fluid
                  onClick={() => {
                    act('deny_pattern');
                  }}
                  color="bad"
                  icon="hammer"
                >
                  Deny Pattern
                </Button>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
