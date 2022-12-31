import { BooleanLike } from 'common/react';
import { useBackend } from '../backend';
import { Divider, Section, Stack } from '../components';
import { Button, ButtonCheckbox } from '../components/Button';
import { Window } from '../layouts';

type Data = {
  food_types: Array<string>;
  selection: Record<number, Array<string>>;
  pref_literally_does_nothing: BooleanLike;
};

export const FoodPreferences = (props, context) => {
  const { act, data } = useBackend<Data>(context);

  return (
    <Window width={600} height={777}>
      <Window.Content scrollable>
        {data.pref_literally_does_nothing === 1 ? (
          <h1>
            You&apos;re using a race which isn&apos;t affected by food
            preferences!
          </h1>
        ) : (
          <Stack vertical>
            {JSON.stringify(data.food_types)}
            {data.food_types.map((element) => {
              return (
                <Stack.Item key={element}>
                  <Section title={element}>
                    <FoodButton
                      foodName={element}
                      foodFlag={3}
                      content="Toxic"
                      color="olive"
                    />
                    {/* <FoodButton
                      foodName={element}
                      foodFlag={2}
                      content="Disliked"
                      color="red"
                    /> */}
                    <FoodButton
                      foodName={element}
                      foodFlag={0}
                      content="Neutral"
                      color="grey"
                    />
                    {/* <FoodButton
                      foodName={element}
                      foodFlag={1}
                      content="Liked"
                      color="green"
                    /> */}
                  </Section>
                </Stack.Item>
              );
            })}
            <Divider />
            <Button color={'red'} onClick={act('reset')} maxWidth="10em">
              Reset
            </Button>
          </Stack>
        )}
      </Window.Content>
    </Window>
  );
};

const FoodButton = (props, context) => {
  const { act } = useBackend(context);
  const { food_name, food_flag, selected, ...rest } = props;
  if (selected) {
    return (
      <ButtonCheckbox
        selected
        onClick={() =>
          act('change_food', {
            food_name: food_name,
            food_flag: food_flag,
          })
        }
        {...rest}
      />
    );
  }
  return (
    <ButtonCheckbox
      onClick={() =>
        act('change_food', {
          food_name: food_name,
          food_flag: food_flag,
        })
      }
      {...rest}
    />
  );
};
