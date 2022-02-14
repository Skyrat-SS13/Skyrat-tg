import { useBackend } from '../backend';
import { Stack, Section, Button, Divider, Dropdown } from '../components';
import { Window } from '../layouts';

type PatternsList = {
  patterns: PatternData[];
  category: string;
  is_admin: boolean;
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

export const PatternTable = (props, context) => {
  const { act, data } = useBackend<PatternsList>(context);
  return (
    <Window
      title="Pattern Table"
      width={400}
      height={670}>
      <Window.Content>
        <Stack fill>
          <Stack.Item grow>
            <Section fill scrollable title="Patterns">
              <Stack fill vertical>
                <Stack vertical>
                  <Stack.Item>
                    Category:
                  </Stack.Item>
                  <Stack.Item>
                    <Dropdown
                      width="100%"
                      selected={data.category}
                      options={
                        ["Back", "Face", "Neck", "Belt", "Ears", "Glasses", "Gloves", "Hat", "Shoes", "Suit", "Jumpsuit"]
                      }
                      onSelected={(value) => act('select_category', { category: value })}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Divider />
                  </Stack.Item>
                </Stack>
                {data.patterns.map((pattern, index) => {
                  return (
                    <Stack.Item fill key={index}>
                      <Pattern pattern={pattern} />
                    </Stack.Item>
                  );
                })}
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const Pattern = (props, context) => {
  const { act, data } = useBackend<PatternsList>(context);
  const { pattern } = props;
  return (
    <Stack vertical>
      <Stack.Item>
        <Button
          fluid
          onClick={() => {
            act('print_pattern', { pattern_id: pattern.id });
          }}
          textAlign="center"
        >
          <Stack vertical>
            <Stack.Item>
              <img src={"clothing_" + pattern.id.toString() + ".png"} />
            </Stack.Item>
            <Stack.Item>
              <Section title={pattern.name}>
                {pattern.desc}
              </Section>
            </Stack.Item>
            <Stack.Item>
              <Divider />
              <Stack>
                <Stack.Item>
                  <i>
                    Author: {pattern.author}
                  </i>
                </Stack.Item>
                <Stack.Item>
                  <i>
                    Uploader: {pattern.ckey_author}
                  </i>
                </Stack.Item>
                <Stack.Item>
                  <i>
                    Pattern ID: {pattern.id}
                  </i>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Button>
      </Stack.Item>
      {data.is_admin ? (
        <Stack.Item>
          <Button
            fluid
            icon="hammer"
            color="bad"
            textAlign="center"
            onClick={() => {
              act('ban_pattern_admin', { pattern_id: pattern.id });
            }}
          >
            [ADMIN] Ban Pattern
          </Button>
          <Divider />
        </Stack.Item>
      ) : (null)}
    </Stack>
  );
};
