import { useBackend } from '../backend';
import { Window } from '../layouts';
import { BlockQuote, Button, Divider, Section, Box, Flex, Collapsible, LabeledList } from '../components';

export const Soulcatcher = (props, context) => {
  const { act, data } = useBackend(context);
  const { current_vessel, current_rooms = [] } = data;

  return (
    <Window width={520} height={400} resizable>
      <Window.Content scrollable>
        {current_rooms.map((room) => (
          <Section
            key={room.key}
            title={room.name}
            buttons={
              <>
                <Button
                  icon="pen"
                  tooltip="Change the name of the room"
                  onClick={() =>
                    act('rename_room', { room_ref: room.reference })
                  }>
                  Rename
                </Button>
                <Button
                  icon="trash"
                  tooltip="Delete the room"
                  color="red"
                  onClick={() =>
                    act('delete_room', { room_ref: room.reference })
                  }>
                  Delete
                </Button>
              </>
            }>
            <BlockQuote> {room.description}</BlockQuote>
            <Box>
              <Button
                icon="book"
                tooltip="Changes the description of the room"
                onClick={() =>
                  act('redescribe_room', { room_ref: room.reference })
                }>
                Redecorate
              </Button>

              <Button
                icon="bullhorn"
                tooltip="Sends a message to everyone in the room, without sending a name."
                onClick={() =>
                  act('send_message', {
                    room_ref: room.reference,
                    emote: false,
                    narrate: true,
                  })
                }>
                Announce
              </Button>

              <Button
                icon="scroll"
                tooltip="Performs an emote, without sending a name."
                onClick={() =>
                  act('send_message', {
                    room_ref: room.reference,
                    emote: true,
                    narrate: true,
                  })
                }>
                Narrate
              </Button>

              <Button
                icon="comment"
                tooltip="Speak inside of the room."
                onClick={() =>
                  act('send_message', {
                    room_ref: room.reference,
                    emote: false,
                  })
                }>
                Say
              </Button>

              <Button
                icon="face-smile"
                tooltip="Do an emote inside of the room."
                onClick={() =>
                  act('send_message', {
                    room_ref: room.reference,
                    emote: true,
                  })
                }>
                Emote
              </Button>

              <Button
                icon="pencil"
                tooltip="Edits the name that is sent when emoting and saying."
                onClick={() =>
                  act('modify_name', {
                    room_ref: room.reference,
                  })
                }>
                Edit Name
              </Button>
            </Box>
            {room.souls ? (
              <>
                <br />
                <Box textAlign="center" fontSize="15px" opacity={0.8}>
                  <b>Curent Souls</b>
                </Box>
                <Divider />
                <Flex direction="column">
                  {room.souls.map((soul) => (
                    <Flex.Item key={soul.key}>
                      <Collapsible
                        title={soul.name}
                        buttons={
                          <Button
                            icon="door-open"
                            tooltip="Transfer a soul to another room"
                            onClick={() =>
                              act('transfer_soul', {
                                room_ref: room.reference,
                                target_soul: soul.ref,
                              })
                            }
                          />
                        }>
                        <BlockQuote>{soul.description}</BlockQuote>
                        <br />
                        <LabeledList>
                          <LabeledList.Item label="Outside Hearing">
                            <Button
                              color="green"
                              fluid
                              tooltip="Is the soul able to hear the outside world?">
                              Enabled
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="Outside Sight">
                            <Button
                              color="green"
                              fluid
                              tooltip="Is the soul able to see the outside world?">
                              Enabled
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="Hearing">
                            <Button
                              color="green"
                              fluid
                              tooltip="Is the soul able to hear inside the room?">
                              Enabled
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="Sight">
                            <Button
                              color="green"
                              fluid
                              tooltip="Is the soul able to see inside the room?">
                              Enabled
                            </Button>
                          </LabeledList.Item>
                        </LabeledList>
                        <br />
                        <Button fluid icon="eject" color="red">
                          Remove Soul
                        </Button>
                      </Collapsible>
                    </Flex.Item>
                  ))}
                </Flex>
              </>
            ) : (
              <> </>
            )}
          </Section>
        ))}
        <Button
          fluid
          color="green"
          icon="plus"
          onClick={() => act('create_room', {})}>
          Create new room
        </Button>
      </Window.Content>
    </Window>
  );
};
