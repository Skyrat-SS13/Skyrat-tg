import { Fragment, useState } from 'react';

import { useBackend } from '../../../backend';
import {
  Box,
  Button,
  Divider,
  Icon,
  Input,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from '../../../components';
import { CharacterPreview } from '../../common/CharacterPreview';
import { ServerData } from '../data';
import { ServerPreferencesFetcher } from '../ServerPreferencesFetcher';
import {
  LoadoutCategory,
  LoadoutItem,
  LoadoutManagerData,
  typePath,
} from './base';
import { ItemIcon, LoadoutTabDisplay, SearchDisplay } from './ItemDisplay';
import { LoadoutModifyDimmer } from './ModifyPanel';

export const LoadoutPage = () => {
  return (
    <ServerPreferencesFetcher
      render={(serverData) => {
        if (!serverData) {
          return <NoticeBox>Loading...</NoticeBox>;
        }
        const loadoutServerData: ServerData = serverData;
        return (
          <LoadoutPageInner
            loadout_tabs={loadoutServerData.loadout.loadout_tabs}
          />
        );
      }}
    />
  );
};

const LoadoutPageInner = (props: { loadout_tabs: LoadoutCategory[] }) => {
  const { loadout_tabs } = props;
  const [searchLoadout, setSearchLoadout] = useState('');
  const [selectedTabName, setSelectedTab] = useState(loadout_tabs[0].name);
  const [modifyItemDimmer, setModifyItemDimmer] = useState<LoadoutItem | null>(
    null,
  );

  return (
    <Stack vertical fill>
      <Stack.Item>
        {!!modifyItemDimmer && (
          <LoadoutModifyDimmer
            modifyItemDimmer={modifyItemDimmer}
            setModifyItemDimmer={setModifyItemDimmer}
          />
        )}
        <Section
          title="&nbsp;"
          align="center"
          buttons={
            <Input
              width="200px"
              onInput={(_, value) => setSearchLoadout(value)}
              placeholder="Search for an item..."
              value={searchLoadout}
            />
          }
        >
          <Tabs fluid align="center">
            {loadout_tabs.map((curTab) => (
              <Tabs.Tab
                key={curTab.name}
                selected={
                  searchLoadout.length <= 1 && curTab.name === selectedTabName
                }
                onClick={() => {
                  setSelectedTab(curTab.name);
                  setSearchLoadout('');
                }}
              >
                <Box>
                  {curTab.category_icon && (
                    <Icon name={curTab.category_icon} mr={1} />
                  )}
                  {curTab.name}
                </Box>
              </Tabs.Tab>
            ))}
          </Tabs>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <LoadoutTabs
          loadout_tabs={loadout_tabs}
          currentTab={selectedTabName}
          currentSearch={searchLoadout}
          modifyItemDimmer={modifyItemDimmer}
          setModifyItemDimmer={setModifyItemDimmer}
        />
      </Stack.Item>
    </Stack>
  );
};

const LoadoutTabs = (props: {
  loadout_tabs: LoadoutCategory[];
  currentTab: string;
  currentSearch: string;
  modifyItemDimmer: LoadoutItem | null;
  setModifyItemDimmer: (dimmer: LoadoutItem | null) => void;
}) => {
  const {
    loadout_tabs,
    currentTab,
    currentSearch,
    modifyItemDimmer,
    setModifyItemDimmer,
  } = props;
  const activeCategory = loadout_tabs.find((curTab) => {
    return curTab.name === currentTab;
  });
  const searching = currentSearch.length > 1;

  return (
    <Stack fill height="550px">
      <Stack.Item align="center" width="250px" height="100%">
        <Stack vertical fill>
          <Stack.Item height="60%">
            <LoadoutPreviewSection />
          </Stack.Item>
          <Stack.Item grow>
            <LoadoutSelectedSection
              all_tabs={loadout_tabs}
              modifyItemDimmer={modifyItemDimmer}
              setModifyItemDimmer={setModifyItemDimmer}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        {searching || activeCategory?.contents ? (
          <Section
            title={searching ? 'Searching...' : 'Catalog'}
            fill
            scrollable
            buttons={
              activeCategory?.category_info ? (
                <Box italic mt={0.5}>
                  {activeCategory.category_info}
                </Box>
              ) : null
            }
          >
            <Stack vertical>
              <Stack.Item>
                {searching ? (
                  <SearchDisplay
                    loadout_tabs={loadout_tabs}
                    currentSearch={currentSearch}
                  />
                ) : (
                  <LoadoutTabDisplay category={activeCategory} />
                )}
              </Stack.Item>
            </Stack>
          </Section>
        ) : (
          <Section fill>
            <Box>No contents for selected tab.</Box>
          </Section>
        )}
      </Stack.Item>
    </Stack>
  );
};

const typepathToLoadoutItem = (
  typepath: typePath,
  all_tabs: LoadoutCategory[],
) => {
  // Maybe a bit inefficient, could be replaced with a hashmap?
  for (const tab of all_tabs) {
    for (const item of tab.contents) {
      if (item.path === typepath) {
        return item;
      }
    }
  }
  return null;
};

const LoadoutSelectedItem = (props: {
  path: typePath;
  all_tabs: LoadoutCategory[];
  modifyItemDimmer: LoadoutItem | null;
  setModifyItemDimmer: (dimmer: LoadoutItem | null) => void;
}) => {
  const { all_tabs, path, modifyItemDimmer, setModifyItemDimmer } = props;
  const { act } = useBackend();

  const item = typepathToLoadoutItem(path, all_tabs);
  if (!item) {
    return null;
  }

  return (
    <Stack align={'center'}>
      <Stack.Item>
        <ItemIcon item={item} scale={1} />
      </Stack.Item>
      <Stack.Item width="55%">{item.name}</Stack.Item>
      {item.buttons.length ? (
        <Stack.Item>
          <Button
            color="none"
            width="32px"
            onClick={() => {
              setModifyItemDimmer(item);
            }}
          >
            <Icon size={1.8} name="cogs" color="grey" />
          </Button>
        </Stack.Item>
      ) : (
        <Stack.Item width="32px" /> // empty space
      )}
      <Stack.Item>
        <Button
          color="none"
          width="32px"
          onClick={() => act('select_item', { path: path, deselect: true })}
        >
          <Icon size={2.4} name="times" color="red" />
        </Button>
      </Stack.Item>
    </Stack>
  );
};

const LoadoutSelectedSection = (props: {
  all_tabs: LoadoutCategory[];
  modifyItemDimmer: LoadoutItem | null;
  setModifyItemDimmer: (dimmer: LoadoutItem | null) => void;
}) => {
  const { act, data } = useBackend<LoadoutManagerData>();
  const { loadout_list } = data.character_preferences.misc;
  const { all_tabs, modifyItemDimmer, setModifyItemDimmer } = props;

  return (
    <Section
      title="&nbsp;"
      scrollable
      fill
      buttons={
        <Button.Confirm
          icon="times"
          color="red"
          align="center"
          disabled={!loadout_list || Object.keys(loadout_list).length === 0}
          tooltip="Clears ALL selected items from all categories."
          onClick={() => act('clear_all_items')}
        >
          Clear All
        </Button.Confirm>
      }
    >
      {loadout_list &&
        Object.entries(loadout_list).map(([path, item]) => (
          <Fragment key={path}>
            <LoadoutSelectedItem
              path={path}
              all_tabs={all_tabs}
              modifyItemDimmer={modifyItemDimmer}
              setModifyItemDimmer={setModifyItemDimmer}
            />
            <Divider />
          </Fragment>
        ))}
    </Section>
  );
};

const LoadoutPreviewSection = () => {
  const { act, data } = useBackend<LoadoutManagerData>();

  return (
    <Section
      fill
      title="&nbsp;"
      buttons={
        <Button.Checkbox
          align="center"
          checked={data.job_clothes}
          onClick={() => act('toggle_job_clothes')}
        >
          Job Clothes
        </Button.Checkbox>
      }
    >
      <Stack vertical fill>
        <Stack.Item grow align="center">
          <CharacterPreview height="100%" id={data.character_preview_view} />
        </Stack.Item>
        <Stack.Divider />
        <Stack.Item align="center">
          <Stack>
            <Stack.Item>
              <Button
                icon="chevron-left"
                onClick={() =>
                  act('rotate_dummy', {
                    dir: 'left',
                  })
                }
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="chevron-right"
                onClick={() =>
                  act('rotate_dummy', {
                    dir: 'right',
                  })
                }
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
