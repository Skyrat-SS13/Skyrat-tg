import { useBackend } from '../backend';
import { Button, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const InteractionMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const { nones } = data; // Interaction categories
  const { self, ref_self, ref_user } = data;
  const { block_interact } = data;

  return (
    <Window width={400} height={600} title={"Interact - " + self}>
      {block_interact && (
        <NoticeBox>Unable to Interact yet!</NoticeBox>
      )}
      {nones.length && (
        <Section title="Miscellaneous">
          {nones.map((item) => (
            <Button
              key={item}
              disabled={block_interact}
              icon="exclamation-circle"
              content={item}
              color="grey"
              onClick={() => act('interact', { interaction: item, selfref: ref_self, userref: ref_user })}
            />
          ))}
        </Section>) || (
        <NoticeBox>No Miscellaneous Interactions</NoticeBox>
      )}
    </Window>
  );
};
