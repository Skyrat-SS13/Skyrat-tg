import { useBackend, useSharedState } from '../backend';
import { Box, Button, Dimmer, Section, Stack, Tabs, Dropdown } from '../components';
import { Window } from '../layouts';
import { CharacterPreview } from "./CharacterPreview";

export const LoadoutManager = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    selected_loadout,
    loadout_tabs,
    user_is_donator,
    mob_name,
    preivew_options,
    preview_selection,
    tutorial_status,
  } = data;

  const [selectedTabName, setSelectedTab] = useSharedState(
    context, 'tabs', loadout_tabs[0]?.name);
  const selectedTab = loadout_tabs.find(curTab => {
    return curTab.name === selectedTabName;
  });

  return (
    <Window
      title="Loadout Manager"
      width={900}
      height={650}>
      <Window.Content>
        { !!tutorial_status && (
          <LoadoutTutorialDimmer />
        )}
        <Stack fill vertical>
          <Stack.Item>
            <Section
              title="Loadout Categories"
              align="center"
              buttons={(
                <Button
                  icon="info"
                  align="center"
                  content="Tutorial"
                  onClick={() => act('toggle_tutorial')} />
              )}>
              <Tabs fluid align="center">
                {loadout_tabs.map(curTab => (
                  <Tabs.Tab
                    key={curTab.name}
                    selected={curTab.name === selectedTabName}
                    onClick={() => setSelectedTab(curTab.name)}>
                    {curTab.name}
                  </Tabs.Tab>
                ))}
              </Tabs>
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <Stack fill>
              <Stack.Item grow>
                { selectedTab && selectedTab.contents ? (
                  <Section
                    title={selectedTab.title}
                    fill
                    scrollable
                    buttons={(
                      <Button.Confirm
                        icon="times"
                        color="red"
                        align="center"
                        content="Clear All Items"
                        tooltip="Clears ALL selected items from all categories."
                        width={10}
                        onClick={() => act('clear_all_items')} />
                    )}>
                    <Stack grow vertical>
                      {selectedTab.contents.map(item => (
                        <Stack.Item key={item.name}>
                          <Stack fontSize="15px">
                            <Stack.Item grow align="left">
                              {item.name}
                            </Stack.Item>
                            <Stack.Item>
                              <Button.Checkbox
                                checked={selected_loadout.includes(item.path)}
                                content="Select"
                                disabled={
                                  !!item.is_donator_only && !user_is_donator
                                }
                                fluid
                                tooltip={item.tooltip_text
                                  ? (item.tooltip_text) : ("")}
                                onClick={() => act('select_item', {
                                  path: item.path,
                                  deselect:
                                    selected_loadout.includes(item.path),
                                })} />
                            </Stack.Item>
                          </Stack>
                        </Stack.Item>
                      ))}
                    </Stack>
                  </Section>
                ) : (
                  <Section fill>
                    <Box>
                      No contents for selected tab.
                    </Box>
                  </Section>
                )}
              </Stack.Item>
              <Stack.Item grow>
                <Section
                  title={`Preview: ${mob_name}`}
                  fill
                  buttons={(
                    <Dropdown
                      fill horizontal
                      selected={preview_selection}
                      options={preivew_options}
                      onSelected={value => act('update_preview', {
                        updated_preview: value,
                      })} />
                  )}>
                  <LoadoutPreview />
                </Section>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

export const LoadoutTutorialDimmer = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    tutorial_text,
  } = data;
  return (
    <Dimmer>
      <Stack
        vertical
        align="center">
        <Stack.Item
          textAlign="center"
          fontSize="14px"
          preserveWhitespace>
          {tutorial_text}
        </Stack.Item>
        <Stack.Item>
          <Button
            mt={1}
            align="center"
            fontSize="20px"
            onClick={() => act('toggle_tutorial')}>
            Okay.
          </Button>
        </Stack.Item>
      </Stack>
    </Dimmer>
  );
};

export const LoadoutPreview = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    character_preview_view: string,
  } = data;

  return (
    <Stack vertical fill>
      <Stack.Item grow>
        <CharacterPreview
          width="100%"
          height="100%"
          align="center"
          id={data.character_preview_view} />
      </Stack.Item>
      <Stack.Divider />
      <Stack.Item align="center">
        <Stack>
          <Stack.Item>
            <Button
              icon="check-double"
              color="good"
              tooltip="Confirm loadout and exit UI."
              onClick={() => act('close_ui', { revert: 0 })} />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="chevron-left"
              tooltip="Turn model preview to the left."
              onClick={() => act('rotate_dummy', {
                dir: "left",
              })} />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="sync"
              tooltip="Toggle viewing all \
              preview directions at once."
              onClick={() => act('show_all_dirs')} />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="chevron-right"
              tooltip="Turn model preview to the right."
              onClick={() => act('rotate_dummy', {
                dir: "right",
              })} />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="times"
              color="bad"
              tooltip="Revert loadout and exit UI."
              onClick={() => act('close_ui', { revert: 1 })} />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};
