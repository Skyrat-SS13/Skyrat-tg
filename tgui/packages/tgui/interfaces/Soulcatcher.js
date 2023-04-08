import { useBackend } from '../backend';
import { Window } from '../layouts';
import { BlockQuote, Button, Divider, LabeledList, Section, Box } from '../components';

export const Soulcatcher = (props, context) => {
  const { act, data } = useBackend(context);
  const { current_vessel, current_rooms = [] } = data;

  return (
    <Window width={500} height={400} resizable>
      <Window.Content>
        {current_rooms.map((room) => (
          <Section
            key={room.key}
            title={room.name}
            buttons={
              <>
                <Button icon="pen" tooltip="Change the name of the room">
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
            <Button icon="book">Redecorate</Button>
            {room.souls ? (
              <>
                <Box textAlign="center" fontSize="15px" opacity={0.8}>
                  <b>Curent Souls</b>
                </Box>
                <Divider />
                <LabeledList>
                  {room.souls.map((soul) => (
                    <LabeledList.Item
                      key={soul.key}
                      label={soul.name}
                      buttons={
                        <>
                          <Button icon="door-open">Transfer</Button>
                          <Button icon="eject" color="red">
                            Remove
                          </Button>
                        </>
                      }>
                      {soul.description}
                    </LabeledList.Item>
                  ))}
                </LabeledList>
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
