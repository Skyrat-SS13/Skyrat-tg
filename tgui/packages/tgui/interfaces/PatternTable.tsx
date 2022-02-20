import { useBackend } from '../backend';
import { Stack, Section, Button, Divider, Dropdown, Input } from '../components';
import { Window } from '../layouts';

type PatternsList = {
  patterns: PatternData[];
  category: string;
  is_admin: boolean;
  ckey_user: string;
  search_string: string;
  search_include_name: boolean;
  search_include_desc: boolean;
  search_include_author: boolean;
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
                    Search:
                  </Stack.Item>
                  <Stack.Item>
                    <Input
                      value={data.search_string}
                      fluid
                      onChange={(e, value) => act('set_search_string', { input: value })}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Stack>
                      <Stack.Item>
                        <Button.Checkbox
                          content="Name"
                          textAlign="center"
                          checked={data.search_include_name}
                          onClick={() => act("set_search_include_name")}
                          fluid
                        />
                      </Stack.Item>
                      <Stack.Item>
                        <Button.Checkbox
                          content="Description"
                          textAlign="center"
                          checked={data.search_include_desc}
                          onClick={() => act("set_search_include_desc")}
                          fluid
                        />
                      </Stack.Item>
                      <Stack.Item>
                        <Button.Checkbox
                          content="Author"
                          textAlign="center"
                          checked={data.search_include_author}
                          onClick={() => act("set_search_include_author")}
                          fluid
                        />
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                  <Stack.Item>
                    <Divider />
                  </Stack.Item>
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
        <Divider />
      </Stack.Item>
      <Stack.Item>
        <Section title={pattern.name}>
          <img src={"clothing_" + pattern.id.toString() + ".png"} />
          <p>
            {pattern.desc}
          </p>
        </Section>
      </Stack.Item>
      <Stack vertical>
        <Stack.Item>
          <Divider />
          <Stack>
            <Stack.Item>
              <i>
                Author: {pattern.author}
              </i>
            </Stack.Item>
            {data.is_admin ? (
              <Stack.Item>
                <i>
                  Uploader: {pattern.ckey_author}
                </i>
              </Stack.Item>
            ) : (null)}
            <Stack.Item>
              <i>
                Pattern ID: {pattern.id}
              </i>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
      <Stack.Item>
        <Button
          fluid
          onClick={() => {
            act('print_pattern', { pattern_id: pattern.id });
          }}
          display="inline-block"
          word-wrap="break-word"
          textAlign="center"
          icon="print"
        >
          Print Pattern
        </Button>
      </Stack.Item>
      {data.is_admin || data.ckey_user === pattern.ckey_author ? (
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
            Delist Pattern
          </Button>
        </Stack.Item>
      ) : (null)}
    </Stack>
  );
};
