import { BooleanLike } from 'common/react';
import { useBackend } from '../backend';
import { Box, Divider, Section, StyleableSection } from '../components';
import { Button } from '../components/Button';
import { Window } from '../layouts';

type Data = {
  food_types: Record<string, Record<number, number>>;
  selection: Record<number, Array<string>>;
  points: number;
  enabled: BooleanLike;
  is_valid: BooleanLike;
  pref_literally_does_nothing: BooleanLike;
};

export const FoodPreferences = (props, context) => {
  const { act, data } = useBackend<Data>(context);

  return (
    <Window width={700} height={500}>
      <Window.Content scrollable>
        {data.pref_literally_does_nothing ? (
          <h1 style={{ 'text-align': 'center' }}>
            You&apos;re using a race which isn&apos;t affected by food
            preferences!
          </h1>
        ) : (
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
                {!data.enabled && (
                  <>
                    <h1>Your food preferences are disabled!</h1>
                    <Divider />
                  </>
                )}
                <span>Points left: {data.points}</span>

                <Button
                  style={{ 'position': 'absolute', 'right': '20em' }}
                  color={'red'}
                  onClick={() => act('reset')}>
                  Reset
                </Button>

                <Button
                  style={{ 'position': 'absolute', 'right': '0.5em' }}
                  icon={data.enabled ? 'check-square-o' : 'square-o'}
                  color={data.enabled ? 'green' : 'red'}
                  onClick={() => act('toggle')}>
                  Use Custom Food Preferences
                </Button>
              </Box>
            }>
            <Box style={{ 'columns': '20em' }}>
              {Object.entries(data.food_types).map((element) => {
                const { 0: foodName, 1: foodPointValues } = element;
                return (
                  <Box key={foodName} wrap="wrap">
                    <Section
                      title={foodName}
                      style={{
                        'break-inside': 'avoid-column',
                        'margin-bottom': '1em',
                      }}>
                      <FoodButton
                        foodName={foodName}
                        foodFlag={3}
                        selected={
                          data.selection[foodName] === '3' ||
                          (!data.selection[foodName] &&
                            foodPointValues['5'] === '3')
                        }
                        content={
                          'Toxic' +
                          (foodPointValues && ' (' + foodPointValues['3'] + ')')
                        }
                        color="olive"
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
                          'Disliked' +
                          (foodPointValues && ' (' + foodPointValues['2'] + ')')
                        }
                        color="red"
                      />
                      <FoodButton
                        foodName={foodName}
                        foodFlag={6}
                        selected={
                          data.selection[foodName] === '6' ||
                          (!data.selection[foodName] &&
                            foodPointValues['5'] === '6')
                        }
                        content={
                          'Neutral' +
                          (foodPointValues && ' (' + foodPointValues['6'] + ')')
                        }
                        color="grey"
                      />
                      <FoodButton
                        foodName={foodName}
                        foodFlag={1}
                        selected={
                          data.selection[foodName] === '1' ||
                          (!data.selection[foodName] &&
                            foodPointValues['5'] === '1')
                        }
                        content={
                          'Liked' +
                          (foodPointValues && ' (' + foodPointValues['1'] + ')')
                        }
                        color="green"
                      />
                    </Section>
                  </Box>
                );
              })}
            </Box>
          </StyleableSection>
        )}
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
          food_flag: foodFlag.toString(),
        })
      }
      {...rest}
    />
  );
};
