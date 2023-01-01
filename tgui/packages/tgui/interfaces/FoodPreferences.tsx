import { BooleanLike } from 'common/react';
import { useBackend } from '../backend';
import { Box, Section, StyleableSection } from '../components';
import { Button } from '../components/Button';
import { Window } from '../layouts';

type Data = {
  food_types: Array<string>;
  selection: Record<number, Array<string>>;
  pref_literally_does_nothing: BooleanLike;
};

export const FoodPreferences = (props, context) => {
  const { act, data } = useBackend<Data>(context);

  return (
    <Window width={700} height={500}>
      <Window.Content scrollable>
        {data.pref_literally_does_nothing === 1 ? (
          <h1>
            You&apos;re using a race which isn&apos;t affected by food
            preferences!
          </h1>
        ) : (
          <StyleableSection
            style={{
              'margin-bottom': '1em',
              'break-inside': 'avoid-column',
            }}
            title={
              <Button
                color={'red'}
                onClick={() => act('reset')}
                maxWidth="10em">
                Reset
              </Button>
            }>
            <Box style={{ 'columns': '20em' }}>
              {data.food_types.map((element) => {
                return (
                  <Box key={element} wrap="wrap">
                    <Section title={element}>
                      <FoodButton
                        foodName={element}
                        foodFlag={3}
                        selected={
                          data.selection !== null &&
                          data.selection[element] === 3
                        }
                        content="Toxic"
                        color="olive"
                      />
                      <FoodButton
                        foodName={element}
                        foodFlag={2}
                        selected={
                          data.selection !== null &&
                          data.selection[element] === 2
                        }
                        content="Disliked"
                        color="red"
                      />
                      <FoodButton
                        foodName={element}
                        foodFlag={0}
                        selected={
                          data.selection !== null && !data.selection[element]
                        }
                        content="Neutral"
                        color="grey"
                      />
                      <FoodButton
                        foodName={element}
                        foodFlag={1}
                        selected={
                          data.selection !== null &&
                          data.selection[element] === 1
                        }
                        content="Liked"
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
          food_flag: foodFlag,
        })
      }
      {...rest}
    />
  );
};
