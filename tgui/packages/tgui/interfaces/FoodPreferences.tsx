import { BooleanLike } from 'common/react';
import { useBackend } from '../backend';
import { Box, Dimmer, Divider, Icon, Section, Stack, StyleableSection, Tooltip } from '../components';
import { Button } from '../components/Button';
import { Window } from '../layouts';

type Data = {
  food_types: Record<string, Record<string, string>>;
  selection: Record<number, Array<string>>;
  points: number;
  enabled: BooleanLike;
  invalid: string;
  race_disabled: BooleanLike;
};

export const FoodPreferences = (props, context) => {
  const { act, data } = useBackend<Data>(context);

  return (
    <Window width={800} height={500}>
      <Window.Content scrollable>
        {
          <StyleableSection
            style={{
              'margin-bottom': '1em',
              'break-inside': 'avoid-column',
            }}
            titleStyle={{
              'justify-content': 'center',
            }}
            title={
              <Box>
                <Tooltip
                  position="bottom"
                  content={
                    data.invalid ? (
                      <>
                        Your selected food preferences are invalid!
                        <Divider />
                        {data.invalid.charAt(0).toUpperCase() +
                          data.invalid.slice(1)}
                        !
                      </>
                    ) : (
                      'Your selected food preferences are valid!'
                    )
                  }>
                  <Box inline>
                    {data.invalid && (
                      <Button icon="circle-question" mr="0.5em" />
                    )}
                    <span
                      style={{ 'color': data.invalid ? '#bd2020' : 'inherit' }}>
                      Points left: {data.points}
                    </span>
                  </Box>
                </Tooltip>

                <Button
                  style={{ 'position': 'absolute', 'right': '20em' }}
                  color={'red'}
                  onClick={() => act('reset')}
                  tooltip="Reset to the default values!">
                  Reset
                </Button>

                <Button
                  style={{ 'position': 'absolute', 'right': '0.5em' }}
                  icon={data.enabled ? 'check-square-o' : 'square-o'}
                  color={data.enabled ? 'green' : 'red'}
                  onClick={() => act('toggle')}
                  tooltip={
                    <>
                      Toggles if these food preferences will be applied to your
                      character on spawn.
                      <Divider />
                      Remember, these are mostly suggestions, and you are
                      encouraged to roleplay liking meals that your character
                      likes, even if you don&apos;t have it&apos;s food type
                      liked here!
                    </>
                  }>
                  Use Custom Food Preferences
                </Button>
              </Box>
            }>
            {(data.race_disabled && (
              <ErrorOverlay>
                You&apos;re using a race which isn&apos;t affected by food
                preferences!
              </ErrorOverlay>
            )) ||
              (!data.enabled && (
                <ErrorOverlay>Your food preferences are disabled!</ErrorOverlay>
              ))}
            <Box style={{ 'columns': '21em' }}>
              {Object.entries(data.food_types).map((element) => {
                const { 0: foodName, 1: foodPointValues } = element;
                return (
                  <Box key={foodName} wrap="wrap">
                    <Section
                      title={
                        <>
                          {foodName}
                          {foodPointValues['6'] && (
                            <Tooltip content="This food doesn't count towards your maximum likes, and is free!">
                              <span
                                style={{
                                  'margin-left': '0.3em',
                                  'vertical-align': 'top',
                                  'font-size': '0.75em',
                                }}>
                                <Icon
                                  name="star"
                                  style={{ 'color': 'orange' }}
                                />
                              </span>
                            </Tooltip>
                          )}
                        </>
                      }
                      style={{
                        'break-inside': 'avoid-column',
                        'margin-bottom': '1em',
                      }}>
                      <FoodButton
                        foodName={foodName}
                        foodFlag={3}
                        selected={
                          data.selection[foodName] === '1' ||
                          (!data.selection[foodName] &&
                            foodPointValues['5'] === '1')
                        }
                        content={
                          <>
                            Toxic
                            {foodPointValues &&
                              !foodPointValues['6'] &&
                              ' (' + foodPointValues['1'] + ')'}
                          </>
                        }
                        color="olive"
                        tooltip="Your character will almost immediately throw up on eating anything toxic."
                      />
                      <FoodButton
                        foodName={foodName}
                        foodFlag={2}
                        selected={
                          data.selection[foodName] === '2' ||
                          (!data.selection[foodName] &&
                            foodPointValues['5'] === '2')
                        }
                        content={
                          <>
                            Disliked
                            {foodPointValues &&
                              !foodPointValues['6'] &&
                              ' (' + foodPointValues['2'] + ')'}
                          </>
                        }
                        color="red"
                        tooltip="Your character will become grossed out, before eventually throwing up after a decent intake of disliked food."
                      />
                      <FoodButton
                        foodName={foodName}
                        foodFlag={3}
                        selected={
                          data.selection[foodName] === '3' ||
                          (!data.selection[foodName] &&
                            foodPointValues['5'] === '3')
                        }
                        content={
                          <>
                            Neutral
                            {foodPointValues &&
                              !foodPointValues['6'] &&
                              ' (' + foodPointValues['3'] + ')'}
                          </>
                        }
                        color="grey"
                        tooltip="Your character has very little to say about something that's neutral."
                      />
                      <FoodButton
                        foodName={foodName}
                        foodFlag={1}
                        selected={
                          data.selection[foodName] === '4' ||
                          (!data.selection[foodName] &&
                            foodPointValues['5'] === '4')
                        }
                        content={
                          <>
                            Liked
                            {foodPointValues &&
                              !foodPointValues['6'] &&
                              ' (' + foodPointValues['4'] + ')'}
                          </>
                        }
                        color="green"
                        tooltip="Your character will enjoy anything that's liked."
                      />
                    </Section>
                  </Box>
                );
              })}
            </Box>
          </StyleableSection>
        }
      </Window.Content>
    </Window>
  );
};

const FoodButton = (props, context) => {
  const { act } = useBackend(context);
  const { foodName, foodFlag, color, selected, ...rest } = props;
  return (
    <Button
      icon={selected ? 'check-square-o' : 'square-o'}
      color={selected ? color : 'grey'}
      onClick={() =>
        act('change_food', {
          food_name: foodName,
          food_flag: foodFlag,
        })
      }
      {...rest}
    />
  );
};

const ErrorOverlay = (props, context) => {
  return (
    <Dimmer style={{ 'align-items': 'stretch' }}>
      <Stack vertical mt="7em">
        <Stack.Item color="#bd2020" textAlign="center">
          <h1>{props.children}</h1>
        </Stack.Item>
      </Stack>
    </Dimmer>
  );
};
