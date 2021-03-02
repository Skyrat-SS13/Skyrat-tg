import { sortBy } from 'common/collections';
import { useLocalState } from '../../backend';
import { Button, Flex, Grid, Section, Tabs } from '../../components';

const diffMap = {
  0: {
    icon: 'times-circle',
    color: 'bad',
  },
  1: {
    icon: 'stop-circle',
    color: null,
  },
  2: {
    icon: 'check-circle',
    color: 'good',
  },
};

export const AccessList = (props, context) => {
  const {
    accesses = [],
    selectedList = [],
    accessMod,
    grantAll,
    denyAll,
    grantDep,
    denyDep,
  } = props;
  const [
    selectedAccessName,
    setSelectedAccessName,
  ] = useLocalState(context, 'accessName', accesses[0]?.name);
  const selectedAccess = accesses
    .find(access => access.name === selectedAccessName);
  const selectedAccessEntries = sortBy(
    entry => entry.desc,
  )(selectedAccess?.accesses || []);

<<<<<<< HEAD
  const checkAccessIcon = accesses => {
    let oneAccess = false;
    let oneInaccess = false;
    for (let element of accesses) {
      if (selectedList.includes(element.ref)) {
        oneAccess = true;
=======
  const parsedRegions = [];
  const selectedTrimAccess = [];
  accesses.forEach(region => {
    const regionName = region.name;
    const regionAccess = region.accesses;
    const parsedRegion = {
      name: regionName,
      accesses: [],
      hasSelected: false,
      allSelected: true,
    };

    // If we're showing the basic accesses included as part of the trim,
    // we want to figure out how many are selected for later formatting
    // logic.
    if (showBasic) {
      regionAccess.forEach(access => {
        if (trimAccess.includes(access.ref)
          && selectedList.includes(access.ref)
          && !selectedTrimAccess.includes(access.ref)
        ) {
          selectedTrimAccess.push(access.ref);
        }
      });
    }

    // If there's no wildcard selected, grab accesses in
    // the trimAccess list as they require no wildcard.
    if (selectedWildcard === "None") {
      regionAccess.forEach(access => {
        if (!trimAccess.includes(access.ref)) {
          return;
        }
        parsedRegion.accesses.push(access);
        if (selectedList.includes(access.ref)) {
          parsedRegion.hasSelected = true;
        }
        else {
          parsedRegion.allSelected = false;
        }
      });
      if (parsedRegion.accesses.length) {
        parsedRegions.push(parsedRegion);
      }
      return;
    }
    // Otherwise, a trim is selected. We want to grab all
    // accesses not in trimAccess that are compatible with
    // the given wildcard.
    regionAccess.forEach(access => {
      if (trimAccess.includes(access.ref)) {
        return;
>>>>>>> 3e63ce55fa1 (Tweak how the ID Console displays wildcard and trim information. (#57322))
      }
      else {
        oneInaccess = true;
      }
    }
    if (!oneAccess && oneInaccess) {
      return 0;
    }
    else if (oneAccess && oneInaccess) {
      return 1;
    }
    else {
      return 2;
    }
  };

  return (
    <Section
      title="Access"
<<<<<<< HEAD
      buttons={(
        <>
          <Button
            icon="check-double"
            content="Grant All"
            color="good"
            onClick={() => grantAll()} />
          <Button
            icon="undo"
            content="Deny All"
            color="bad"
            onClick={() => denyAll()} />
        </>
      )}>
      <Flex>
=======
      buttons={extraButtons} >
      <Flex wrap="wrap">
        <Flex.Item width="100%">
          <FormatWildcards
            wildcardSlots={wildcardSlots}
            selectedList={selectedList}
            showBasic={showBasic}
            basicUsed={selectedTrimAccess.length}
            basicMax={trimAccess.length} />
        </Flex.Item>
>>>>>>> 3e63ce55fa1 (Tweak how the ID Console displays wildcard and trim information. (#57322))
        <Flex.Item>
          <Tabs vertical>
            {accesses.map(access => {
              const entries = access.accesses || [];
              const icon = diffMap[checkAccessIcon(entries)].icon;
              const color = diffMap[checkAccessIcon(entries)].color;
              return (
                <Tabs.Tab
                  key={access.name}
                  altSelection
                  color={color}
                  icon={icon}
                  selected={access.name === selectedAccessName}
                  onClick={() => setSelectedAccessName(access.name)}>
                  {access.name}
                </Tabs.Tab>
              );
            })}
          </Tabs>
        </Flex.Item>
        <Flex.Item grow={1}>
          <Grid>
            <Grid.Column mr={0}>
              <Button
                fluid
                icon="check"
                content="Grant Region"
                color="good"
                onClick={() => grantDep(selectedAccess.regid)} />
            </Grid.Column>
            <Grid.Column ml={0}>
              <Button
                fluid
                icon="times"
                content="Deny Region"
                color="bad"
                onClick={() => denyDep(selectedAccess.regid)} />
            </Grid.Column>
          </Grid>
          {selectedAccessEntries.map(entry => (
            <Button.Checkbox
              fluid
              key={entry.desc}
              content={entry.desc}
              checked={selectedList.includes(entry.ref)}
              onClick={() => accessMod(entry.ref)} />
          ))}
        </Flex.Item>
      </Flex>
    </Section>
  );
};
<<<<<<< HEAD
=======

export const FormatWildcards = (props, context) => {
  const {
    wildcardSlots = {},
    showBasic,
    basicUsed = 0,
    basicMax = 0,
  } = props;

  const [
    wildcardTab,
    setWildcardTab,
  ] = useSharedState(context, "wildcardSelected", showBasic ? "None" : Object.keys(wildcardSlots)[0]);

  let selectedWildcard;

  if ((wildcardTab !== "None") && !wildcardSlots[wildcardTab]) {
    selectedWildcard = showBasic ? "None" : Object.keys(wildcardSlots)[0];
    setWildcardTab(selectedWildcard);
  }
  else {
    selectedWildcard = wildcardTab;
  }

  return (
    <Tabs>
      {showBasic && (
        <Tabs.Tab
          selected={selectedWildcard === "None"}
          onClick={() => setWildcardTab("None")} >
          Trim:<br />{basicUsed + "/" + basicMax}
        </Tabs.Tab>
      )}

      {Object.keys(wildcardSlots).map(wildcard => {
        const wcObj = wildcardSlots[wildcard];
        let wcLimit = wcObj.limit;
        const wcUsage = wcObj.usage.length;
        const wcLeft = wcLimit - wcUsage;
        if (wcLeft < 0) {
          wcLimit = "∞";
        }
        const wcLeftStr = `${wcUsage}/${wcLimit}`;
        return (
          <Tabs.Tab
            key={wildcard}
            selected={selectedWildcard === wildcard}
            onClick={() => setWildcardTab(wildcard)} >
            {wildcard + ":"}<br />{wcLeftStr}
          </Tabs.Tab>
        );
      })}
    </Tabs>
  );
};

const RegionTabList = (props, context) => {
  const {
    accesses = [],
  } = props;

  const [
    selectedAccessName,
    setSelectedAccessName,
  ] = useSharedState(context, 'accessName', accesses[0]?.name);

  return (
    <Tabs vertical>
      {accesses.map(access => {
        const icon = (access.allSelected && "check")
          || (access.hasSelected && "minus")
          || "times";
        return (
          <Tabs.Tab
            key={access.name}
            icon={icon}
            minWidth={"100%"}
            altSelection
            selected={access.name === selectedAccessName}
            onClick={() => setSelectedAccessName(access.name)}>
            {access.name}
          </Tabs.Tab>
        );
      })}
    </Tabs>
  );
};

const RegionAccessList = (props, context) => {
  const {
    accesses = [],
    selectedList = [],
    accessMod,
    trimAccess = [],
    accessFlags = {},
    accessFlagNames = {},
    wildcardSlots = {},
    showBasic,
  } = props;

  const [
    wildcardTab,
    setWildcardTab,
  ] = useSharedState(context, "wildcardSelected", showBasic ? "None" : Object.keys(wildcardSlots)[0]);

  let selWildcard;

  if ((wildcardTab !== "None") && !wildcardSlots[wildcardTab]) {
    selWildcard = showBasic ? "None" : Object.keys(wildcardSlots)[0];
    setWildcardTab(selWildcard);
  }
  else {
    selWildcard = wildcardTab;
  }

  const [
    selectedAccessName,
  ] = useSharedState(context, 'accessName', accesses[0]?.name);

  const selectedAccess = accesses
    .find(access => access.name === selectedAccessName);
  const selectedAccessEntries = sortBy(
    entry => entry.desc,
  )(selectedAccess?.accesses || []);

  const allWildcards = Object.keys(wildcardSlots);
  let wcAccess = {};
  allWildcards.forEach(wildcard => {
    wildcardSlots[wildcard].usage.forEach(access => {
      wcAccess[access] = wildcard;
    });
  });

  const wildcard = wildcardSlots[selWildcard];
  // If there's no wildcard, -1 limit as there's infinite basic slots.
  const wcLimit = wildcard ? wildcard.limit : -1;
  const wcUsage = wildcard ? wildcard.usage.length : 0;
  const wcAvail = wcLimit - wcUsage;

  return (
    selectedAccessEntries.map(entry => {
      const id = entry.ref;
      const disableButton = (
        ((wcAvail === 0) && (wcAccess[id] !== selWildcard))
        || ((wcAvail > 0) && wcAccess[id] && wcAccess[id] !== selWildcard));
      const entryName = (!wcAccess[id] && trimAccess.includes(id))
        ? entry.desc : entry.desc + " (" + accessFlagNames[accessFlags[id]] + ")";

      return (
        <Button.Checkbox
          ml={1}
          fluid
          key={entry.desc}
          content={entryName}
          disabled={disableButton}
          checked={selectedList.includes(entry.ref)}
          onClick={() => accessMod(
            entry.ref,
            (selWildcard === "None") ? null : selWildcard)} />
      );
    })
  );
};
>>>>>>> 3e63ce55fa1 (Tweak how the ID Console displays wildcard and trim information. (#57322))
