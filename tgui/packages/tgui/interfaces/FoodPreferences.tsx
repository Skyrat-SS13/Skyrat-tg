// THIS IS A SKYRAT UI FILE
import { useBackend } from '../backend';
import {
  Box,
  Dimmer,
  Divider,
  Icon,
  Section,
  Stack,
  StyleableSection,
  Tooltip,
} from '../components';
import { Button } from '../components/Button';
import { Window } from '../layouts';

type Data = {
  food_types: Record<string, number>;
  obscure_food_types: string;
  selection: Record<string, number>;
  enabled: boolean;
  invalid: string;
  race_disabled: boolean;
};

const FOOD_TOXIC = 1;
const FOOD_DISLIKED = 2;
const FOOD_NEUTRAL = 3;
const FOOD_LIKED = 4;
const DEFAULT_FOOD_VALUE = 4;
const OBSCURE_FOOD = 5;

export const FoodPreferences = (props) => {
  const { act, data } = useBackend<Data>();

  return (
    <Window width={1300} height={600}>
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
                    'You HAVE to pick at lease ONE TOXIC food and THREE Disliked foods. You Can have a maximum of THREE LIKED foods.'
                  }
                >
                  <Box inline>
                    <Button icon="circle-question" mr="0.5em" />
                    {data.invalid ? (
                      <Box as="span" color="#bd2020">
                        Prefrences are Invalid!{' '}
                        {data.invalid.charAt(0).toUpperCase() +
                          data.invalid.slice(1)}{' '}
                        |&nbsp;
                      </Box>
                    ) : (
                      <Box as="span" color="green">
                        Prefrences are Valid!
                      </Box>
                    )}
                  </Box>
                </Tooltip>

                <Button
                  style={{ position: 'absolute', right: '20em' }}
                  color={'red'}
                  onClick={() => act('reset')}
                  tooltip="Reset to the default values!"
                >
                  Reset
                </Button>

                <Button
                  style={{ position: 'absolute', right: '0.5em' }}
                  icon={data.enabled ? 'check-square-o' : 'square-o'}
                  color={data.enabled ? 'green' : 'red'}
                  onClick={() => act('toggle')}
                  disabled={data.race_disabled}
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
                  }
                >
                  Use Custom Food Preferences
                </Button>
              </Box>
            }
          >
            {(data.race_disabled && (
              <ErrorOverlay>
                You&apos;re using a race which isn&apos;t affected by food
                preferences!
              </ErrorOverlay>
            )) ||
              (!data.enabled && (
                <ErrorOverlay>Your food preferences are disabled!</ErrorOverlay>
              ))}
            <Box style={{ columns: '30em' }}>
              {Object.entries(data.food_types).map((element) => {
                const { 0: foodName, 1: foodPointValues } = element;
                return (
                  <Box key={foodName}>
                    <Section
                      title={
                        <>
                          {foodName}
                          {data.obscure_food_types[foodName] && (
                            <Tooltip content="This food doesn't count towards your maximum likes, and is free!">
                              <Box
                                as="span"
                                fontSize={0.75}
                                verticalAlign={'top'}
                              >
                                <Icon name="star" style={{ color: 'orange' }} />
                              </Box>
                            </Tooltip>
                          )}
                        </>
                      }
                    >
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_TOXIC}
                        selected={
                          data.selection[foodName] === FOOD_TOXIC ||
                          (!data.selection[foodName] &&
                            foodPointValues === FOOD_TOXIC)
                        }
                        content={<>Toxic</>}
                        color="olive"
                        tooltip="Your character will almost immediately throw up on eating anything toxic."
                      />
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_DISLIKED}
                        selected={
                          data.selection[foodName] === FOOD_DISLIKED ||
                          (!data.selection[foodName] &&
                            foodPointValues === FOOD_DISLIKED)
                        }
                        content={<>Disliked</>}
                        color="red"
                        tooltip="Your character will become grossed out, before eventually throwing up after a decent intake of disliked food."
                      />
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_NEUTRAL}
                        selected={
                          data.selection[foodName] === FOOD_NEUTRAL ||
                          (!data.selection[foodName] &&
                            foodPointValues === FOOD_NEUTRAL)
                        }
                        content={<>Neutral</>}
                        color="yellow"
                        tooltip="Your character has very little to say about something that's neutral."
                      />
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_LIKED}
                        selected={
                          data.selection[foodName] === FOOD_LIKED ||
                          (!data.selection[foodName] &&
                            foodPointValues === FOOD_LIKED)
                        }
                        content={<>Liked</>}
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

const FoodButton = (props) => {
  const { act } = useBackend();
  const { foodName, foodPreference, color, selected, ...rest } = props;
  return (
    <Button
      icon={selected ? 'check-square-o' : 'square-o'}
      color={selected ? color : 'grey'}
      onClick={() =>
        act('change_food', {
          food_name: foodName,
          food_preference: foodPreference,
        })
      }
      {...rest}
    />
  );
};

const ErrorOverlay = (props) => {
  return (
    <Dimmer>
      <Stack vertical mt="5.2em">
        <Stack.Item color="#bd2020" textAlign="center">
          {props.children}
        </Stack.Item>
      </Stack>
    </Dimmer>
  );
};
