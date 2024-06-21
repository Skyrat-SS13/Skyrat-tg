import { BooleanLike } from 'common/react';
import { Component, Fragment } from 'react';

import { resolveAsset } from '../../assets';
import { useBackend } from '../../backend';
import {
  Box,
  Button,
  Dimmer,
  Section,
  Stack,
  Tabs,
  Tooltip,
} from '../../components';
import { fetchRetry } from '../../http';
import { Window } from '../../layouts';
import {
  calculateDangerLevel,
  calculateProgression,
  dangerDefault,
  dangerLevelsTooltip,
} from './calculateDangerLevel';
import { GenericUplink, Item } from './GenericUplink';
import { Objective, ObjectiveMenu } from './ObjectiveMenu';
import { PrimaryObjectiveMenu } from './PrimaryObjectiveMenu';

type UplinkItem = {
  id: string;
  name: string;
  cost: number;
  desc: string;
  category: string;
  purchasable_from: number;
  restricted: BooleanLike;
  limited_stock: number;
  stock_key: string;
  restricted_roles: string;
  restricted_species: string;
  progression_minimum: number;
  cost_override_string: string;
  lock_other_purchases: BooleanLike;
  ref?: string;
};

type UplinkData = {
  telecrystals: number;
  progression_points: number;
  lockable: BooleanLike;
  current_expected_progression: number;
  progression_scaling_deviance: number;
  current_progression_scaling: number;
  uplink_flag: number;
  assigned_role: string;
  assigned_species: string;
  debug: BooleanLike;
  extra_purchasable: UplinkItem[];
  extra_purchasable_stock: {
    [key: string]: number;
  };
  current_stock: {
    [key: string]: number;
  };

  has_objectives: BooleanLike;
  has_progression: BooleanLike;
  primary_objectives: {
    [key: number]: string;
  };
  completed_final_objective: string;
  potential_objectives: Objective[];
  active_objectives: Objective[];
  maximum_active_objectives: number;
  maximum_potential_objectives: number;
  purchased_items: number;
  shop_locked: BooleanLike;
  can_renegotiate: BooleanLike;
};

type UplinkState = {
  allItems: UplinkItem[];
  allCategories: string[];
  currentTab: number;
};

type ServerData = {
  items: UplinkItem[];
  categories: string[];
};

type ItemExtraData = Item & {
  extraData: {
    ref?: string;
  };
};

// Cache response so it's only sent once
let fetchServerData: Promise<ServerData> | undefined;

export class Uplink extends Component<{}, UplinkState> {
  constructor(props) {
    super(props);
    this.state = {
      allItems: [],
      allCategories: [],
      currentTab: 0,
    };
  }

  componentDidMount() {
    this.populateServerData();
  }

  async populateServerData() {
    if (!fetchServerData) {
      fetchServerData = fetchRetry(resolveAsset('uplink.json')).then(
        (response) => response.json(),
      );
    }
    const { data } = useBackend<UplinkData>();

    const uplinkFlag = data.uplink_flag;
    const uplinkRole = data.assigned_role;
    const uplinkSpecies = data.assigned_species;

    const uplinkData = await fetchServerData;
    uplinkData.items = uplinkData.items.sort((a, b) => {
      if (a.progression_minimum < b.progression_minimum) {
        return -1;
      }
      if (a.progression_minimum > b.progression_minimum) {
        return 1;
      }
      return 0;
    });

    const availableCategories: string[] = [];
    uplinkData.items = uplinkData.items.filter((value) => {
      if (
        value.restricted_roles.length > 0 &&
        !value.restricted_roles.includes(uplinkRole) &&
        !data.debug
      ) {
        return false;
      }
      if (
        value.restricted_species.length > 0 &&
        !value.restricted_species.includes(uplinkSpecies) &&
        !data.debug
      ) {
        return false;
      }
      {
        if (value.purchasable_from & uplinkFlag) {
          return true;
        }
      }
      return false;
    });

    uplinkData.items.forEach((item) => {
      if (!availableCategories.includes(item.category)) {
        availableCategories.push(item.category);
      }
    });

    uplinkData.categories = uplinkData.categories.filter((value) =>
      availableCategories.includes(value),
    );

    this.setState({
      allItems: uplinkData.items,
      allCategories: uplinkData.categories,
    });
  }

  render() {
    const { data, act } = useBackend<UplinkData>();
    const {
      telecrystals,
      progression_points,
      primary_objectives,
      can_renegotiate,
      completed_final_objective,
      active_objectives,
      potential_objectives,
      has_objectives,
      has_progression,
      maximum_active_objectives,
      maximum_potential_objectives,
      current_expected_progression,
      progression_scaling_deviance,
      current_progression_scaling,
      extra_purchasable,
      extra_purchasable_stock,
      current_stock,
      lockable,
      purchased_items,
      shop_locked,
    } = data;
    const { allItems, allCategories, currentTab } = this.state as UplinkState;

    const itemsToAdd = [...allItems];
    const items: ItemExtraData[] = [];
    itemsToAdd.push(...extra_purchasable);
    for (let i = 0; i < extra_purchasable.length; i++) {
      const item = extra_purchasable[i];
      if (!allCategories.includes(item.category)) {
        allCategories.push(item.category);
      }
    }
    for (let i = 0; i < itemsToAdd.length; i++) {
      const item = itemsToAdd[i];
      const hasEnoughProgression =
        progression_points >= item.progression_minimum;

      let stock: number | null = current_stock[item.stock_key];
      if (item.ref) {
        stock = extra_purchasable_stock[item.ref];
      }
      if (!stock && stock !== 0) {
        stock = null;
      }
      const canBuy = telecrystals >= item.cost && (stock === null || stock > 0);
      items.push({
        id: item.id,
        name: item.name,
        category: item.category,
        desc: (
          <Box>
            {item.desc}
            {(item.lock_other_purchases && (
              <Box color="orange" bold>
                Taking this item will lock you from further purchasing from the
                marketplace. Additionally, if you have already purchased an
                item, you will not be able to purchase this.
              </Box>
            )) ||
              null}
          </Box>
        ),
        cost: (
          <Box>
            {item.cost_override_string || `${item.cost} TC`}
            {has_progression ? (
              <>
                ,&nbsp;
                <Box as="span">
                  {calculateDangerLevel(item.progression_minimum, true)}
                </Box>
              </>
            ) : (
              ''
            )}
          </Box>
        ),
        disabled:
          !canBuy ||
          (has_progression && !hasEnoughProgression) ||
          (item.lock_other_purchases && purchased_items > 0),
        extraData: {
          ref: item.ref,
        },
      });
    }
    // Get the difference between the current progression and
    // expected progression
    let progressionPercentage =
      current_expected_progression - progression_points;
    // Clamp it down between 0 and 2
    progressionPercentage = Math.min(
      Math.max(progressionPercentage / progression_scaling_deviance, -1),
      1,
    );
    // Round it and convert it into a percentage
    progressionPercentage = Math.round(progressionPercentage * 1000) / 10;
    return (
      <Window width={820} height={580} theme="syndicate">
        <Window.Content scrollable={currentTab !== 0 || !has_objectives}>
          <Stack vertical fill>
            <Stack.Item>
              <Section>
                <Stack>
                  <Stack.Item grow={1} align="center">
                    <Box fontSize={0.8}>
                      SyndOS Version 3.17 &nbsp;
                      <Box color="green" as="span">
                        Connection Secure
                      </Box>
                    </Box>
                    <Box color="green" bold fontSize={1.2}>
                      WELCOME, AGENT.
                    </Box>
                  </Stack.Item>
                  <Stack.Item align="center">
                    <Box bold fontSize={1.2}>
                      <Tooltip
                        content={
                          (!!has_progression && (
                            <Box>
                              <Box>
                                <Box>Your current level of threat.</Box> Threat
                                determines
                                {has_objectives
                                  ? ' the severity of secondary objectives you get and '
                                  : ' '}
                                what items you can purchase.&nbsp;
                                <Box mt={0.5}>
                                  {/* A minute in deciseconds */}
                                  Threat passively increases by{' '}
                                  <Box color="green" as="span">
                                    {calculateProgression(
                                      current_progression_scaling,
                                    )}
                                  </Box>
                                  &nbsp;every minute
                                </Box>
                                {Math.abs(progressionPercentage) > 0 && (
                                  <Box mt={0.5}>
                                    Because your threat level is
                                    {progressionPercentage < 0
                                      ? ' ahead '
                                      : ' behind '}
                                    of where it should be, you are getting
                                    <Box
                                      as="span"
                                      color={
                                        progressionPercentage < 0
                                          ? 'red'
                                          : 'green'
                                      }
                                      ml={1}
                                      mr={1}
                                    >
                                      {progressionPercentage}%
                                    </Box>
                                    {progressionPercentage < 0
                                      ? 'less'
                                      : 'more'}{' '}
                                    threat every minute
                                  </Box>
                                )}
                                {dangerLevelsTooltip}
                              </Box>
                            </Box>
                          )) ||
                          "Your current threat level. You are a killing machine and don't need to improve your threat level."
                        }
                      >
                        {/* If we have no progression,
                      just give them a generic title */}
                        {has_progression
                          ? calculateDangerLevel(progression_points, false)
                          : calculateDangerLevel(dangerDefault, false)}
                      </Tooltip>
                    </Box>
                    <Box color="good" bold fontSize={1.2} textAlign="right">
                      {telecrystals} TC
                    </Box>
                  </Stack.Item>
                </Stack>
              </Section>
            </Stack.Item>
            <Stack.Item>
              <Section fitted>
                <Stack align="center">
                  <Stack.Item grow={1}>
                    <Tabs fluid textAlign="center">
                      {!!has_objectives && (
                        <>
                          <Tabs.Tab
                            selected={currentTab === 0}
                            onClick={() => this.setState({ currentTab: 0 })}
                          >
                            Primary Objectives
                          </Tabs.Tab>
                          <Tabs.Tab
                            selected={currentTab === 1}
                            onClick={() => this.setState({ currentTab: 1 })}
                          >
                            Secondary Objectives
                          </Tabs.Tab>
                        </>
                      )}
                      <Tabs.Tab
                        selected={currentTab === 2 || !has_objectives}
                        onClick={() => this.setState({ currentTab: 2 })}
                      >
                        Market
                      </Tabs.Tab>
                    </Tabs>
                  </Stack.Item>
                  {!!lockable && (
                    <Stack.Item mr={1}>
                      <Button
                        icon="times"
                        content="Lock"
                        color="transparent"
                        onClick={() => act('lock')}
                      />
                    </Stack.Item>
                  )}
                </Stack>
              </Section>
            </Stack.Item>
            <Stack.Item grow>
              {(currentTab === 0 && has_objectives && (
                <PrimaryObjectiveMenu
                  primary_objectives={primary_objectives}
                  final_objective={completed_final_objective}
                  can_renegotiate={can_renegotiate}
                />
              )) ||
                (currentTab === 1 && has_objectives && (
                  <ObjectiveMenu
                    activeObjectives={active_objectives}
                    potentialObjectives={potential_objectives}
                    maximumActiveObjectives={maximum_active_objectives}
                    maximumPotentialObjectives={maximum_potential_objectives}
                    handleObjectiveAction={(objective, action) =>
                      act('objective_act', {
                        check: objective.original_progression,
                        objective_action: action,
                        index: objective.id,
                      })
                    }
                    handleStartObjective={(objective) =>
                      act('start_objective', {
                        check: objective.original_progression,
                        index: objective.id,
                      })
                    }
                    handleObjectiveAbort={(objective) =>
                      act('objective_abort', {
                        check: objective.original_progression,
                        index: objective.id,
                      })
                    }
                    handleObjectiveCompleted={(objective) =>
                      act('finish_objective', {
                        check: objective.original_progression,
                        index: objective.id,
                      })
                    }
                    handleRequestObjectives={() => act('regenerate_objectives')}
                  />
                )) || (
                  <Section>
                    <GenericUplink
                      currency=""
                      categories={allCategories}
                      items={items}
                      handleBuy={(item: ItemExtraData) => {
                        if (!item.extraData?.ref) {
                          act('buy', { path: item.id });
                        } else {
                          act('buy', { ref: item.extraData.ref });
                        }
                      }}
                    />
                    {(shop_locked && !data.debug && (
                      <Dimmer>
                        <Box
                          color="red"
                          fontFamily={'Bahnschrift'}
                          fontSize={3}
                          align={'top'}
                          as="span"
                        >
                          SHOP LOCKED
                        </Box>
                      </Dimmer>
                    )) ||
                      null}
                  </Section>
                )}
            </Stack.Item>
          </Stack>
        </Window.Content>
      </Window>
    );
  }
}
