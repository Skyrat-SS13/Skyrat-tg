import { useBackend } from '../backend';
import { Button, NoticeBox, Section, Icon, Box, Stack } from '../components';
import { Window } from '../layouts';

class Interaction {
  categories;
  interactions;
  descriptions;
  colors;
  lewd_slots: LewdSlot[];
  self;
  ref_self;
  ref_user;
  block_interact;
}

class LewdSlot {
  img;
  name;
}

export const InteractionMenu = (props, context) => {
  const { act, data } = useBackend<Interaction>(context);
  const {
    categories,
    interactions,
    descriptions,
    colors,
    lewd_slots,
    self,
    ref_self,
    ref_user,
    block_interact,
  } = data;

  return (
    <Window width={400} height={600} title={'Interact - ' + self}>
      <Window.Content scrollable>
        {(block_interact && <NoticeBox>Unable to Interact</NoticeBox>) || (
          <NoticeBox>Able to Interact</NoticeBox>
        )}
        <Section key="interactions">
          {categories.map((category) => (
            <Section key={category} title={category}>
              {interactions[category].map((interaction) => (
                <Section key={interaction}>
                  <Button
                    margin={0}
                    padding={0}
                    disabled={block_interact}
                    color={block_interact ? 'grey' : colors[interaction]}
                    content={interaction}
                    icon="exclamation-circle"
                    onClick={() =>
                      act('interact', {
                        interaction: interaction,
                        selfref: ref_self,
                        userref: ref_user,
                      })
                    }
                  />
                  <br />
                  {descriptions[interaction]}
                </Section>
              ))}
            </Section>
          ))}
        </Section>
        {lewd_slots.length > 0 ? (
          <Section key="lewd_slots" title={'Lewd Slots'}>
            <Stack fill>
              {lewd_slots.map((element: LewdSlot) => {
                return (
                  <Stack.Item key={element.name} style={{}}>
                    <Button
                      onClick={() =>
                        act('remove_lewd_item', {
                          slot: element,
                          selfref: ref_self,
                          userref: ref_user,
                        })
                      }
                      tooltip={element}>
                      <Box width="26px" height="34px">
                        {element.img ? (
                          <img
                            src={'data:image/png;base64,' + element.img}
                            style={{
                              '-ms-interpolation-mode': 'nearest-neighbor',
                              'width': '100%',
                              'height': '100%',
                            }}
                          />
                        ) : (
                          <Icon
                            name="eye-slash"
                            size={1.5}
                            ml={0}
                            mt={1.3}
                            style={{
                              'text-align': 'center',
                            }}
                          />
                        )}
                      </Box>
                    </Button>
                  </Stack.Item>
                );
              })}
            </Stack>
          </Section>
        ) : (
          ''
        )}
      </Window.Content>
    </Window>
  );
};
