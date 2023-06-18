import { useBackend } from '../backend';
import { Window } from '../layouts';
import { BlockQuote, Button, Divider, Box, Flex, Collapsible, LabeledList, Section } from '../components';

export const SoulcatcherUser = (props, context) => {
  const { act, data } = useBackend(context);
  const { current_room, user_data, souls = [] } = data;

  return (
    <Window width={520} height={400} resizable>
      <Window.Content scrollable>
        <Section
          key={current_room.key}
          title={
            <span style={{ color: current_room.color }}>
              {current_room.name}
            </span>
          }>
          <BlockQuote preserveWhitespace>
            {' '}
            {current_room.description}
          </BlockQuote>
        </Section>

        {souls ? (
          <>
            <br />
            <Box textAlign="center" fontSize="15px" opacity={0.8}>
              <b>Other Souls</b>
            </Box>
            <Divider />
            <Flex direction="column">
              {souls.map((soul) => (
                <Flex.Item key={soul.key}>
                  <Collapsible title={soul.name}>
                    <Box textAlign="center" fontSize="13px" opacity={0.8}>
                      <b>Flavor Text</b>
                    </Box>
                    <Divider />
                    <BlockQuote preserveWhitespace>
                      {soul.description}
                    </BlockQuote>
                    <br />
                    <Box textAlign="center" fontSize="13px" opacity={0.8}>
                      <b>OOC Notes</b>
                    </Box>
                    <Divider />
                    <BlockQuote preserveWhitespace>{soul.ooc_notes}</BlockQuote>
                    <br />
                    <LabeledList>
                      <LabeledList.Item label="Outside Hearing">
                        <Button
                          color={soul.outside_hearing ? 'green' : 'red'}
                          fluid
                          tooltip="Is the soul able to hear the outside world?"
                          onClick={() =>
                            act('toggle_soul_outside_sense', {
                              target_soul: soul.reference,
                              sense_to_change: 'hearing',
                              room_ref: room.reference,
                            })
                          }>
                          {soul.outside_hearing ? 'Enabled' : 'Disabled'}
                        </Button>
                      </LabeledList.Item>
                      <LabeledList.Item label="Outside Sight">
                        <Button
                          color={soul.outside_sight ? 'green' : 'red'}
                          fluid
                          tooltip="Is the soul able to see the outside world?"
                          onClick={() =>
                            act('toggle_soul_outside_sense', {
                              target_soul: soul.reference,
                              sense_to_change: 'sight',
                              room_ref: room.reference,
                            })
                          }>
                          {soul.outside_sight ? 'Enabled' : 'Disabled'}
                        </Button>
                      </LabeledList.Item>
                      <LabeledList.Item label="Hearing">
                        <Button
                          color={soul.internal_hearing ? 'green' : 'red'}
                          fluid
                          tooltip="Is the soul able to hear inside the room?"
                          onClick={() =>
                            act('toggle_soul_sense', {
                              target_soul: soul.reference,
                              sense_to_change: 'hearing',
                              room_ref: room.reference,
                            })
                          }>
                          {soul.internal_hearing ? 'Enabled' : 'Disabled'}
                        </Button>
                      </LabeledList.Item>
                      <LabeledList.Item label="Sight">
                        <Button
                          color={soul.internal_sight ? 'green' : 'red'}
                          fluid
                          tooltip="Is the soul able to see inside the room?"
                          onClick={() =>
                            act('toggle_soul_sense', {
                              target_soul: soul.reference,
                              sense_to_change: 'sight',
                              room_ref: room.reference,
                            })
                          }>
                          {soul.internal_sight ? 'Enabled' : 'Disabled'}
                        </Button>
                      </LabeledList.Item>
                      <LabeledList.Item label="Speech">
                        <Button
                          color={soul.able_to_speak ? 'green' : 'red'}
                          fluid
                          tooltip="Is the soul able to speak?"
                          onClick={() =>
                            act('toggle_soul_communication', {
                              target_soul: soul.reference,
                              communication_type: 'speech',
                              room_ref: room.reference,
                            })
                          }>
                          {soul.able_to_speak ? 'Enabled' : 'Disabled'}
                        </Button>
                      </LabeledList.Item>
                      <LabeledList.Item label="Emote">
                        <Button
                          color={soul.able_to_emote ? 'green' : 'red'}
                          fluid
                          tooltip="Is the soul able to emote?"
                          onClick={() =>
                            act('toggle_soul_communication', {
                              target_soul: soul.reference,
                              communication_type: 'emote',
                              room_ref: room.reference,
                            })
                          }>
                          {soul.able_to_emote ? 'Enabled' : 'Disabled'}
                        </Button>
                      </LabeledList.Item>
                    </LabeledList>
                    <br />
                  </Collapsible>
                </Flex.Item>
              ))}
            </Flex>
          </>
        ) : (
          <> </>
        )}
      </Window.Content>
    </Window>
  );
};
