import { useContext } from 'react';

import { useBackend } from '../../backend';
import { Button, Icon, Input, Section, Stack } from '../../components';
import { OrbitContext } from '.';
import { VIEWMODE } from './constants';
import { isJobOrNameMatch, sortByOrbiters } from './helpers';
import { OrbitData } from './types';

/** Search bar for the orbit ui. Has a few buttons to switch between view modes and auto-observe */
export function OrbitSearchBar(props) {
  const {
    autoObserve,
    bladeOpen,
    searchQuery,
    viewMode,
    setAutoObserve,
    setBladeOpen,
    setSearchQuery,
    setViewMode,
  } = useContext(OrbitContext);

  const { act, data } = useBackend<OrbitData>();

  /** Gets a list of Observables, then filters the most relevant to orbit */
  function orbitMostRelevant() {
    const mostRelevant = [
      data.alive,
      data.antagonists,
      data.critical,
      data.deadchat_controlled,
      data.dead,
      data.ghosts,
      data.misc,
      data.npcs,
    ]
      .flat()
      .filter((observable) => isJobOrNameMatch(observable, searchQuery))
      .sort(sortByOrbiters)[0];

    if (mostRelevant !== undefined) {
      act('orbit', {
        ref: mostRelevant.ref,
        auto_observe: autoObserve,
      });
    }
  }

  /** Iterates through the view modes and switches to the next one */
  function swapViewMode() {
    const thisIndex = Object.values(VIEWMODE).indexOf(viewMode);
    const nextIndex = (thisIndex + 1) % Object.values(VIEWMODE).length;

    setViewMode(Object.values(VIEWMODE)[nextIndex]);
  }

  const viewModeTitle = Object.entries(VIEWMODE).find(
    ([_key, value]) => value === viewMode,
  )?.[0];

  return (
    <Section>
      <Stack>
        <Stack.Item>
          <Icon name="search" />
        </Stack.Item>
        <Stack.Item grow>
          <Input
            autoFocus
            fluid
            onEnter={orbitMostRelevant}
            onInput={(event, value) => setSearchQuery(value)}
            placeholder="Search..."
            value={searchQuery}
          />
        </Stack.Item>
        <Stack.Divider />
        <Stack.Item>
          <Button
            color="transparent"
            icon={viewMode}
            onClick={swapViewMode}
            tooltip={`Color scheme: ${viewModeTitle}`}
            tooltipPosition="bottom-start"
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            color={autoObserve ? 'good' : 'transparent'}
            icon={autoObserve ? 'toggle-on' : 'toggle-off'}
            onClick={() => setAutoObserve(!autoObserve)}
            tooltip={`Toggle Auto-Observe. When active, you'll
            see the UI / full inventory of whoever you're orbiting. Neat!`}
            tooltipPosition="bottom-start"
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            color="transparent"
            icon="sync-alt"
            onClick={() => act('refresh')}
            tooltip="Refresh"
            tooltipPosition="bottom-start"
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            color="transparent"
            icon="sliders-h"
            onClick={() => setBladeOpen(!bladeOpen)}
            selected={bladeOpen}
            tooltip="Toggle settings blade"
            tooltipPosition="left-end"
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
}
