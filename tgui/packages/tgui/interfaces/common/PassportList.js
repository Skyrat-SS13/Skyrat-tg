import { useSharedState } from '../../backend';
import { Button, Flex, Section, Tabs } from '../../components';

export const PassportList = (props, context) => {
  const { backgrounds, extraButtons, passportMod, selectedEntries } = props;

  const [selectedTabName, setSelectedTabName] = useSharedState(
    context,
    'selectedEditTab',
    Object.keys(backgrounds)[0]
  );

  return (
    <Section title="Passport Modification" buttons={extraButtons}>
      <Flex wrap="wrap">
        <Flex.Item>
          <BackgroundCategoryTabList tabs={Object.keys(backgrounds)} />
        </Flex.Item>
        <Flex.Item grow={1}>
          <BackgroundEntryList
            backgrounds={backgrounds[selectedTabName]}
            passportMod={passportMod}
            selectedEntry={selectedEntries[selectedTabName]}
          />
        </Flex.Item>
      </Flex>
    </Section>
  );
};

const BackgroundCategoryTabList = (props, context) => {
  const { tabs } = props;

  const [selectedTabName, setSelectedTabName] = useSharedState(
    context,
    'selectedEditTab',
    tabs[0]
  );

  return (
    <Tabs vertical>
      {tabs.map((tab) => {
        return (
          <Tabs.Tab
            key={tab}
            icon={tab === selectedTabName ? 'check' : 'minus'}
            minWidth={'100%'}
            altSelection
            selected={tab === selectedTabName}
            onClick={() => setSelectedTabName(tab)}>
            {tab}
          </Tabs.Tab>
        );
      })}
    </Tabs>
  );
};

const BackgroundEntryList = (props, context) => {
  const { backgrounds, passportMod, selectedEntry } = props;

  return backgrounds.map((entry) => {
    return (
      <Button.Checkbox
        ml={1}
        fluid
        key={entry.path}
        content={entry.name}
        checked={selectedEntry === entry.path}
        onClick={() => passportMod(entry.path)}
      />
    );
  });
};
