import { useBackend, useSharedState } from '../backend';
import { Box, Button, Dimmer, Divider, Section, Stack, Tabs } from '../components';
import { Window } from '../layouts';

export const LoadoutManager = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    selected_loadout,
    loadout_tabs,
    mob_name,
    job_clothes,
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
        <Stack grow vertical>
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
          <Stack.Item>
            <Stack>
              <Stack.Item grow >
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
                    <Stack vertical>
                      {selectedTab.contents.map(item => (
                        <Stack.Item key={item.name}>
                          <Stack fontSize="15px">
                            <Stack.Item grow align="left">
                              {item.name}
                            </Stack.Item>
                            { !!item.is_greyscale
                            && (
                              <Stack.Item>
                                <Button
                                  icon="palette"
                                  onClick={() => act('select_color', {
                                    path: item.path,
                                  })} />
                              </Stack.Item>
                            )}
                            { !!item.is_renamable
                            && (
                              <Stack.Item>
                                <Button
                                  icon="pen"
                                  onClick={() => act('set_name', {
                                    path: item.path,
                                  })} />
                              </Stack.Item>
                            )}
                            { !!item.is_job_restricted
                            && (
                              <Stack.Item>
                                <Button
                                  icon="lock"
                                  onClick={() => act('display_restrictions', {
                                    path: item.path,
                                  })} />
                              </Stack.Item>
                            )}
                            <Stack.Item>
                              <Button.Checkbox
                                checked={selected_loadout.includes(item.path)}
                                content="Select"
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
              <Stack.Item width="50%" align="center">
                <Section
                  title={`Preview: ${mob_name}`}
                  fill
                  buttons={(
                    <Button.Checkbox
                      align="center"
                      content="Toggle Job Clothes"
                      checked={job_clothes}
                      onClick={() => act('toggle_job_clothes')} />
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
    icon64,
    ismoth,
  } = data;
  return (
    <Stack vertical>
      <Stack.Item>
        <Box
          as="img"
          m={0}
          src={`data:image/jpeg;base64,${icon64}`}
          width="100%"
          minWidth={(ismoth ? 48 : 0)} // moths are too fat, break the preview
          style={{
            '-ms-interpolation-mode': 'nearest-neighbor',
          }} />
        <Divider />
      </Stack.Item>
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
