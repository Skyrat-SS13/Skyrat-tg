import { useBackend, useLocalState } from '../backend';
import { Section, Stack, Box, Divider, Button } from '../components';
import { Window } from '../layouts';

export const ArmamentStation = (props, context) => {
  const [category, setCategory] = useLocalState(context, 'category');
  const [weapon, setArmament] = useLocalState(context, 'weapon');
  const { act, data } = useBackend(context);
  const {
    armaments_list = [],
    remaining_points,
  } = data;
  return (
    <Window
      theme="armament"
      title="Armament Station"
      width={1000}
      height={600}>
      <Window.Content>
        <Section fill title="Armaments Station">
          <Box fontSize="20px">Remaining Points: {remaining_points}</Box>
          <Divider />
          <Stack fill grow>
            <Stack.Item mr={1}>
              <Section title="Categories">
                <Stack vertical>
                  {armaments_list.map(armament_category => (
                    <Stack.Item key={armament_category.category}>
                      <Button
                        width="100%"
                        key={armament_category.category}
                        content={armament_category.category + armament_category.category_limit > 0 ? ' (Pick ' + armament_category.category_limit + ')' : ''}
                        selected={category === armament_category.category}
                        onClick={() =>
                          setCategory(armament_category.category)} />
                    </Stack.Item>
                  ))}
                </Stack>
              </Section>
            </Stack.Item>
            <Divider vertical />
            <Stack.Item grow mr={1}>
              {armaments_list.map(armament_category => (
                armament_category.category === category && (
                  armament_category.subcategories.map(subcat => (
                    <Section
                      key={subcat.subcategory}
                      title={subcat.subcategory}>
                      <Stack vertical>
                        {subcat.items.map(item => (
                          <Stack.Item key={item.ref}>
                            <Button
                              fontSize="15px"
                              textAlign="center"
                              selected={weapon === item.ref}
                              width="100%"
                              key={item.ref}
                              onClick={() =>
                                setArmament(item.ref)}>
                              <img
                                src={`data:image/jpeg;base64,${item.icon}`}
                                style={{
                                  'vertical-align': 'middle',
                                  'horizontal-align': 'middle',
                                }}
                              />
                              &nbsp;{item.name}
                            </Button>
                          </Stack.Item>
                        ))}
                      </Stack>
                    </Section>
                  ))
                )
              ))}
            </Stack.Item>
            <Divider vertical />
            <Stack.Item width="20%">
              <Section title="Selected Armament">
                {armaments_list.map(armament_category => (
                  armament_category.subcategories.map(subcat => (
                    subcat.items.map(item => (
                      item.ref === weapon && (
                        <Stack vertical>
                          <Stack.Item>
                            <Box key={item.ref}>
                              <img
                                height="100%"
                                width="100%"
                                src={`data:image/jpeg;base64,${item.icon}`}
                                style={{
                                  'vertical-align': 'middle',
                                  'horizontal-align': 'middle',
                                  '-ms-interpolation-mode': 'nearest-neighbor',
                                }}
                              />
                            </Box>
                          </Stack.Item>
                          <Stack.Item>
                            {item.description}
                          </Stack.Item>
                          <Stack.Item>
                            {'Quantity Remaining: ' + item.quantity - item.purchased}
                          </Stack.Item>
                          <Stack.Item
                            textColor={item.cost > remaining_points ? "red" : "green"}>
                            {'Cost: ' + item.cost}
                          </Stack.Item>
                          <Stack.Item>
                            <Button
                              content="Buy"
                              textAlign="center"
                              width="100%"
                              disabled={item.cost > remaining_points}
                              onClick={() => act('equip_item', {
                                ref: item.ref,
                              })} />
                          </Stack.Item>
                        </Stack>
                      )
                    ))
                  ))
                ))}
              </Section>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
