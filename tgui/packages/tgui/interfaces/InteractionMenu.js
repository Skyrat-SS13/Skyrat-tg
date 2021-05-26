import { useBackend } from '../backend';
import { Button, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const InteractionMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const { categories, ints } = data; // Interaction categories
  const { self, ref_self, ref_user } = data;
  const { block_interact } = data;

  return (
    <Window width={400} height={600} title={"Interact - " + self}>
      {block_interact && (
        <NoticeBox>Unable to Interact</NoticeBox>
      ) || (
        <NoticeBox>Able to Interact</NoticeBox>
      )}
      {categories.map((category) =>(
        <Section key={category} title={category}>
          {ints[category].map((int) => (
            <Button
              key={int}
              disabled={block_interact}
              icon="exclamation-circle"
              content={int}
              color={block_interact ? "grey" : "blue"}
              onClick={() => act('interact', { interaction: int, selfref: ref_self, userref: ref_user })}
              />
          ))}
        </Section>
      ))}
    </Window>
  );
};
